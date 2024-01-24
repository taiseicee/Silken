extends State

func enter_state():
	super()
	#print("Move Machine > Release State")

func process_physics(delta: float):
	super(delta)
	if not character.is_on_floor():
		state_transition.emit(self, "move_fall")
		return
	
	if move_comp.can_anticipate:
		move_comp.can_anticipate = false
		state_transition.emit(self, "move_anticipate")
		return
	
	if character.attack_machine.is_in_state("attack_patrol"):
		move_comp.slide_patrol()
	elif character.attack_machine.is_in_state("attack_pursuit"):
		move_comp.slide_pursuit()
