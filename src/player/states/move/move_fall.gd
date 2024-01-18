extends State

func enter_state():
	super()
	print("Move Machine > Fall State")

func process_physics(_delta: float):
	if movement_comp.is_on_floor():
		state_transition.emit(self, "move_idle")
		return
	if character.can_swing:
		state_transition.emit(self, "move_swing")
	
