extends State

func enter_state():
	super()
	#print("Web Machine > Swing State")

func process_input(_event: InputEvent):
	if not Input.is_key_pressed(movement_comp.second_key):
		state_transition.emit(self, "web_idle")
		character.dismiss_web.emit()
		return
