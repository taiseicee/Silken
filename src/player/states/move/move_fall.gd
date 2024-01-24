extends State

func enter_state():
	super()
	#print("Move Machine > Fall State")

func process_physics(_delta: float):
	if not character.web_machine.is_in_state("web_swing") and move_comp.is_on_floor():
		state_transition.emit(self, "move_idle")
		return
