extends Node
class_name FiniteStateMachine

@export
var start_state: State
var current_state: State
var states: Dictionary

func init(character: RigidBody2D, movement_comp: Node):
	for child in get_children():
		var state := child as State
		if not state:
			continue
		states[state.name.to_lower()] = child
		state.state_transition.connect(change_state)
		state.character = character
		state.movement_comp = movement_comp
	
	assert(start_state, "ERROR: You must give a start state")
	
	start_state.enter_state()
	current_state = start_state;

func change_state(source_state: State, new_state_name: String):
	if source_state != current_state:
		print("WARNING: Change state from ", source_state.name, " to ", new_state_name, " but the current state is ", current_state.name)
	
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
