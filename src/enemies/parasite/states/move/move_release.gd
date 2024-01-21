extends State

func enter_state():
	super()
	print("Move Machine > Release State")

func process_physics(delta: float):
	super(delta)
	if movement_comp.can_anticipate:
		movement_comp.can_anticipate = false
		state_transition.emit(self, "move_anticipate")
		return
	
	if character.attack_machine.is_in_state("attack_patrol"):
		movement_comp.slide_patrol()
	elif character.attack_machine.is_in_state("attack_pursuit"):
		movement_comp.slide_pursuit()
