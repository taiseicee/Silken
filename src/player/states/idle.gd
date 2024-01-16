extends State

func enter_state():
	super()
	print("Entered: Idle State")

func process_input(event: InputEvent) -> State:
	var key_event := event as InputEventKey
	if key_event && event.is_pressed():
		movement_comp.first_key = key_event.get_keycode_with_modifiers()
		movement_comp.print_key(movement_comp.first_key)
	return null
