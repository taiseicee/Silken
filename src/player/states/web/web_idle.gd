extends State

func enter_state():
	super()
	#print("Web Machine > Idle State")

func process_frame(delta: float):
	move_comp.head_return(delta)
	
	if Input.is_action_pressed("primary_action"):
		move_comp.attack()

func process_input(event: InputEvent):
	super(event)
	var key_event := event as InputEventKey
	if not key_event || not event.is_pressed():
		return
	var is_valid_key = move_comp.set_first_key(key_event.get_keycode_with_modifiers())
	if is_valid_key:
		state_transition.emit(self, "web_aim")
