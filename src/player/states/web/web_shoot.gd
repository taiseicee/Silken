extends State

func enter_state():
	super()
	print("Entered: Shoot State")

func process_input(event: InputEvent):
	if not Input.is_key_pressed(movement_comp.second_key):
		character.can_swing = false
		state_transition.emit(self, "web_aim")
	if not Input.is_key_pressed(movement_comp.first_key):
		character.can_swing = true
