extends State

func enter_state():
	super()
	#print("Web Machine > Swing State")
	action_comp.swing()

func process_frame(delta: float):
	super(delta)
	if Input.is_action_pressed("primary_action"):
		action_comp.attack()

func process_input(event: InputEvent):
	super(event)
	
	var key_event := event as InputEventKey
	if not key_event: return
	if key_event.is_released() && key_event.get_keycode_with_modifiers() == action_comp.second_key:
		action_comp.second_key = null
		state_transition.emit(self, "web_idle")
		character.dismiss_web.emit()
