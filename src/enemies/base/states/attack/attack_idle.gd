extends State

func enter_state():
	super()

func process_frame(delta: float):
	super(delta)
	if character.move_machine.is_in_state("move_death"): return
	state_transition.emit(self, "attack_patrol")
