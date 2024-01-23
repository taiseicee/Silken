extends State

func enter_state():
	super()
	#print("Web Machine > Aim State")
	animation_player.play("web_aim")

func process_frame(delta: float):
	movement_comp.head_return(delta)
	
	if Input.is_action_pressed("primary_action"):
		movement_comp.attack()

func process_input(event: InputEvent):
	if not Input.is_key_pressed(movement_comp.first_key):
		state_transition.emit(self, "web_idle")
		return
	var key_event := event as InputEventKey
	if not key_event || not event.is_pressed():
		return
	if key_event.get_keycode_with_modifiers() == movement_comp.first_key:
		return
	var is_valid_key = movement_comp.set_second_key(key_event.get_keycode_with_modifiers())
	if is_valid_key:
		state_transition.emit(self, "web_shoot")

func exit_state():
	animation_player.play_backwards("web_aim")
