extends State

func enter_state():
	super()
	#print("Web Machine > Swing State")

func process_input(_event: InputEvent):
	if not Input.is_key_pressed(move_comp.second_key):
		move_comp.second_key = null
		state_transition.emit(self, "web_idle")
		character.dismiss_web.emit()
		return
