extends State

func enter_state():
	super()
	#print("Attack Machine > Patrol State")
	movement_comp.init_patrol()

func process_physics(_delta):
	if movement_comp.should_pursue():
		state_transition.emit(self, "attack_pursuit")
		return
