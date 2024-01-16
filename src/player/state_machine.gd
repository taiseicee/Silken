extends Node

@export
var start_state: State
var current_state: State

func init(character: CharacterBody2D, movement_comp: Node):
	for state: State in get_children():
		state.character = character
		state.movement_comp = movement_comp

func change_state(new_state: State):
	if current_state:
		current_state.exit_state()
	
	current_state = new_state
	current_state.enter_state()

func process_frame(delta: float):
	var new_state: State = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent):
	var new_state: State = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_physics(delta: float):
	var new_state: State = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
