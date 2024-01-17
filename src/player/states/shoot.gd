extends State

func enter_state():
	super()
	movement_comp.shoot()
	print("Entered: Shoot State")

func process_input(event: InputEvent):
	super(event)
	if not Input.is_key_pressed(movement_comp.second_key):
		state_transition.emit(self, "aim")
	if not Input.is_key_pressed(movement_comp.first_key):
		movement_comp.shoot()
		state_transition.emit(self, "swing")
