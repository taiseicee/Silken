extends State

func enter_state():
	super.enter_state()
	print("Attack Machine > Pursuit State")

func process_frame(delta):
	if not movement_comp.should_pursue():
		state_transition.emit(self, "attack_patrol")
