extends State

func enter_state():
	super()
	print("Move Machine > Idle State")

func process_physics(_delta: float):
	if movement_comp.is_on_floor():
		return
	if character.can_swing:
		state_transition.emit(self, "move_swing")
		return
	state_transition.emit(self, "move_fall")
	