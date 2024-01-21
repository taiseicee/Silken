extends State

func enter_state():
	super()
	#print("Attack Machine > Pursuit State")
	movement_comp.init_pursuit()

func process_frame(_delta):
	if not movement_comp.should_pursue():
		state_transition.emit(self, "attack_patrol")
		return
	
	if movement_comp.is_within_attack_range():
		state_transition.emit(self, "attack_attack")
		return
