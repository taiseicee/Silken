extends State

func enter_state():
	super()
	#print("Move Machine > Idle State")
	animation_player.queue("move_idle")

func process_physics(_delta: float):
	if character.web_machine.is_in_state("web_swing") || not move_comp.is_on_floor():
		state_transition.emit(self, "move_fall")
		return
