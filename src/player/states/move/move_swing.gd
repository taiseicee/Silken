extends State

func enter_state():
	super()
	#print("Move Machine > Swing State")
	move_comp.swing()
	animation_player.queue("move_swing")

func process_physics(_delta: float):
	if character.web_machine.is_in_state("web_swing"):
		return
	
	if move_comp.is_on_floor():
		state_transition.emit(self, "move_idle")
		character.dismiss_web.emit()
		return
		
	state_transition.emit(self, "move_fall")
	character.dismiss_web.emit()

func exit_state():
	animation_player.play_backwards("move_swing")
