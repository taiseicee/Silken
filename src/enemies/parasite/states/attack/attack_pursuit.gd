extends State

func enter_state():
	super()
	#print("Attack Machine > Pursuit State")
	move_comp.init_pursuit()

func process_frame(_delta):
	if not move_comp.should_pursue():
		state_transition.emit(self, "attack_patrol")
		return
	
	if move_comp.is_within_attack_range():
		state_transition.emit(self, "attack_attack")
		return
