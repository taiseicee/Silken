extends State

func enter_state():
	super()
	print("Move Machine > Idle State")
	character.gravity_scale = 0

func process_physics(_delta: float):
	if character.can_swing:
		state_transition.emit(self, "move_swing")
		return
	state_transition.emit(self, "move_fall")
	
