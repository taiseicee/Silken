extends State

func enter_state():
	super()
	print("Move Machine > Idle State")

func process_frame(delta: float):
	super(delta)
	if character.attack_machine.is_in_state("attack_patrol"):
		state_transition.emit(self, "move_anticipate")
		return
	
	if character.attack_machine.is_in_state("attack_pursuit"):
		state_transition.emit(self, "move_anticipate")
		return
