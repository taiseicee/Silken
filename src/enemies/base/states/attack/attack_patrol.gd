extends State

func enter_state():
	super()
	#print("Attack Machine > Patrol State")

func process_physics(_delta):
	if action_comp.should_pursue():
		state_transition.emit(self, "attack_alet")
		return
