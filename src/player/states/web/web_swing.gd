extends State

func enter_state():
	super()
	#print("Web Machine > Swing State")
	action_comp.swing()

func process_input(_event: InputEvent):
	if not Input.is_key_pressed(action_comp.second_key):
		action_comp.second_key = null
		state_transition.emit(self, "web_idle")
		character.dismiss_web.emit()
		return
