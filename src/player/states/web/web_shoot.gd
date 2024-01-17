extends State

func enter_state():
	super()
	print("Web Machine > Shoot State")
	movement_comp.shoot()

func process_frame(_delta: float):
	redraw_web()

func process_input(_event: InputEvent):
	if Input.is_key_pressed(movement_comp.first_key) && Input.is_key_pressed(movement_comp.second_key):
		character.can_swing = false
		return
	if Input.is_key_pressed(movement_comp.first_key) && not Input.is_key_pressed(movement_comp.second_key):
		character.can_swing = false
		movement_comp.first_key = movement_comp.second_key
		movement_comp.second_key = null
		state_transition.emit(self, "web_aim")
		redraw_web()
		return
	if not Input.is_key_pressed(movement_comp.first_key) && Input.is_key_pressed(movement_comp.second_key):
		character.can_swing = true
		return
	if not Input.is_key_pressed(movement_comp.first_key) && not Input.is_key_pressed(movement_comp.second_key):
		character.can_swing = false
		state_transition.emit(self, "web_idle")
		redraw_web()

func redraw_web():
	character.queue_redraw()
	character.draw.emit()
