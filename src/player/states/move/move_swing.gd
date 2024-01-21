extends State

func enter_state():
	super()
	print("Move Machine > Swing State")
	movement_comp.swing()
	character.gravity_scale = 1

func process_physics(_delta: float):
	if movement_comp.is_on_floor():
		state_transition.emit(self, "move_idle")
		character.dismiss_web.emit()
		return
	if not character.can_swing:
		state_transition.emit(self, "move_fall")
		character.dismiss_web.emit()
