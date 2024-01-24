extends Node
class_name FiniteStateMachine

@export
var start_state: State
var current_state: State
var states: Dictionary

func init(character: PhysicsBody2D, 
		  move_comp: Node = null, 
		  action_comp: Node = null, 
		  animation_player: AnimationPlayer = null):
	for child in get_children():
		var state := child as State
		if not state:
			continue
		states[state.name.to_lower()] = state
		state.state_transition.connect(change_state)
		state.character = character
		if move_comp:
			state.move_comp = move_comp
		if action_comp:
			state.action_comp = action_comp
		if animation_player:
			state.animation_player = animation_player
	
	assert(start_state, "ERROR: You must give a start state")
	
	start_state.enter_state()
	current_state = start_state;

func is_in_state(state_name: String):
	return current_state.name.to_lower() == state_name

func force_change_state(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	
	assert(new_state, "ERROR: Invalid state")
	
	if current_state == new_state:
		print("WARNING: Attempting to force change into the current state %s" % [new_state_name])
	
	if current_state:
		var exit_callable = Callable(current_state, "Exit")
		exit_callable.call_deferred()
	
	current_state = new_state
	current_state.enter_state()

func change_state(source_state: State, new_state_name: String):
	if source_state != current_state:
		print(
			"WARNING: Request to change state from %s to %s, but the current state is %s" %
			[source_state.name, new_state_name, current_state.name]
		)
	
	var new_state = states.get(new_state_name.to_lower())
	assert(new_state, "ERROR: Invalid state")
	
	if current_state:
		current_state.exit_state()
	current_state = new_state
	current_state.enter_state()

func process_frame(delta: float):
	if current_state:
		current_state.process_frame(delta)

func process_input(event: InputEvent):
	if current_state:
		current_state.process_input(event)

func process_physics(delta: float):
	if current_state:
		current_state.process_physics(delta)
