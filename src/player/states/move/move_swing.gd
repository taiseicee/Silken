extends State

func enter_state():
	super()
	print("Move Machine > Swing State")

func process_physics(_delta: float):
	if movement_comp.is_on_floor():
		state_transition.emit(self, "move_idle")
		return
	if not character.can_swing:
		state_transition.emit(self, "move_fall")
	
