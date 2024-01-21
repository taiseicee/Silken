extends State

func enter_state():
	super.enter_state()
	print("Attack Machine > Patrol State")
	movement_comp.init_patrol()

func process_physics(delta):
	if movement_comp.should_pursue():
		state_transition.emit(self, "attack_pursuit")
		return
