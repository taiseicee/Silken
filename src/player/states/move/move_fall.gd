extends State

func enter_state():
	super()
	print("Move Machine > Fall State")
	character.gravity_scale = 1

func process_physics(_delta: float):
	if movement_comp.is_on_floor():
		state_transition.emit(self, "move_idle")
		character.gravity_scale = 0
		return
	
	if character.can_swing:
		state_transition.emit(self, "move_swing")
