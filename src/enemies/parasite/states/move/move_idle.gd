extends State

func enter_state():
	super.enter_state()
	print("Move Machine > Idle State")

func process_frame(delta: float):
	super(delta)
	if character.attack_machine.is_in_state("attack_patrol"):
		state_transition.emit(self, "move_anticipate")
		return
	
	if not movement_comp.is_within_attack_range():
		state_transition.emit(self, "move_anticipate")
		return
