extends State

func enter_state():
	super()
	print("Move Machine > Anticipate State")

func process_physics(_delta: float):
	print(movement_comp.should_change_direction())
	if movement_comp.should_change_direction():
		print("- changing direction")
		movement_comp.change_direction()
	state_transition.emit(self, "move_release")
