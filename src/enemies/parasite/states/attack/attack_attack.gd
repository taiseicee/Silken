extends State

func enter_state():
	super.enter_state()
	print("Attack Machine > Attack State")

func process_frame(delta: float):
	if not movement_comp.is_within_attack_range():
		state_transition.emit(self, "attack_pursuit")
		return
