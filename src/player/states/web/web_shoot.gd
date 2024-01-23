extends State

func enter_state():
	super()
	#print("Web Machine > Shoot State")
	movement_comp.shoot()

func process_frame(delta: float):
	if character.move_machine.is_in_state("move_swing"):
		movement_comp.in_swing_turn(delta)
	elif character.move_machine.is_in_state("move_idle") or character.move_machine.is_in_state("move_fall"):
		movement_comp.in_shoot_turn(delta)
	
	if Input.is_action_pressed("primary_action"):
		movement_comp.attack()
	
func process_input(_event: InputEvent):
	if Input.is_key_pressed(movement_comp.first_key) && not Input.is_key_pressed(movement_comp.second_key):
		movement_comp.second_key = null
		state_transition.emit(self, "web_aim")
		character.dismiss_web.emit()
		return
	if not Input.is_key_pressed(movement_comp.first_key) && Input.is_key_pressed(movement_comp.second_key):
		state_transition.emit(self, "web_swing")
		return
	if not Input.is_key_pressed(movement_comp.first_key) && not Input.is_key_pressed(movement_comp.second_key):
		state_transition.emit(self, "web_idle")
		character.dismiss_web.emit()
		return
