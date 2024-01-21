extends State

func enter_state():
	super()
	print("Move Machine > Release State")

func process_physics(_delta: float):
	state_transition.emit(self, "move_anticipate")
