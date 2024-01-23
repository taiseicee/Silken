extends State

func enter_state():
	super()
	#print("Move Machine > Fall State")

func process_physics(delta: float):
	if character.is_on_floor():
		state_transition.emit(self, "move_idle")
		return
	
	move_comp.handle_gravity(delta)
