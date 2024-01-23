extends State

func enter_state():
	super()
	#print("Web Machine > Aim State")
	animation_player.play("web_aim")

func process_frame(delta: float):
	super(delta)
	move_comp.head_return(delta)
	
	if Input.is_action_pressed("primary_action"):
		action_comp.attack()

func process_input(event: InputEvent):
	super(event)
	var key_event := event as InputEventKey
	if not key_event: return
	
	if key_event.is_released() && key_event.get_keycode_with_modifiers() == action_comp.first_key:
		state_transition.emit(self, "web_idle")
		return
	if not event.is_pressed() || key_event.get_keycode_with_modifiers() == action_comp.first_key: 
		return
	
	var is_valid_key = action_comp.set_second_key(key_event.get_keycode_with_modifiers())
	if is_valid_key:
		state_transition.emit(self, "web_shoot")

func exit_state():
	animation_player.play_backwards("web_aim")
