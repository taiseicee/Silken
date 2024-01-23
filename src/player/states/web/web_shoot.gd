extends State

func enter_state():
	super()
	#print("Web Machine > Shoot State")
	action_comp.shoot()

func process_frame(delta: float):
	super(delta)
	action_comp.in_shoot_turn(delta)
	
	if Input.is_action_pressed("primary_action"):
		action_comp.attack()
		
	if Input.is_key_pressed(action_comp.first_key) && not Input.is_key_pressed(action_comp.second_key):
		action_comp.second_key = null
		state_transition.emit(self, "web_aim")
		character.dismiss_web.emit()
		return
	
	if not Input.is_key_pressed(action_comp.first_key) && Input.is_key_pressed(action_comp.second_key):
		state_transition.emit(self, "web_swing")
		return
	
	if not Input.is_key_pressed(action_comp.first_key) && not Input.is_key_pressed(action_comp.second_key):
		state_transition.emit(self, "web_idle")
		character.dismiss_web.emit()
		return

