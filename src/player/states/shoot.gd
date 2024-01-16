extends State

func enter_state():
	super()
	print("Entered: Shoot State")

func process_input(event: InputEvent):
	if not Input.is_key_pressed(movement_comp.second_key):
		state_transition.emit(self, "aim")
	if not Input.is_key_pressed(movement_comp.first_key):
		state_transition.emit(self, "swing")
