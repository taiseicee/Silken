extends State

func enter_state():
	super()
	print("Move Machine > Release State")

func process_physics(delta: float):
	super(delta)
	if movement_comp.should_anticipate():
		state_transition.emit(self, "move_anticipate")
		return
	movement_comp.slide(delta)
