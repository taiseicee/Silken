extends State

func enter_state():
	super()
	#print("Attack Machine > Alert State")

func process_frame(_delta):
	if not action_comp.should_pursue():
		state_transition.emit(self, "attack_patrol")
		return
	
	state_transition.emit(self, "attack_attack")
