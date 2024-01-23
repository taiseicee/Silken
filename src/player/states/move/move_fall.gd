extends State

func enter_state():
	super()
	#print("Move Machine > Fall State")
	character.gravity_scale = 1
	#animation_player.play("move_fall")
	animation_player.queue("move_fall")

func process_physics(_delta: float):
	if movement_comp.is_on_floor():
		state_transition.emit(self, "move_idle")
		character.gravity_scale = 0
		return
	
	if character.web_machine.is_in_state("web_swing"):
		state_transition.emit(self, "move_swing")
		return
