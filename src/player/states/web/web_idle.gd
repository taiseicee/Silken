extends State

func enter_state():
	super()
	#print("Web Machine > Idle State")

func process_frame(delta: float):
	super(delta)
	move_comp.head_return(delta)
	action_comp.update_dash_bar()
	
	if character.move_machine.is_in_state("move_death"):
		return

	if Input.is_action_just_pressed("primary_action"):
		action_comp.dash()

func process_input(event: InputEvent):
	super(event)
	
	if character.move_machine.is_in_state("move_death"):
		return
	
	var key_event := event as InputEventKey
	if not key_event || not event.is_pressed():
		return
	var is_valid_key = action_comp.set_first_key(key_event.get_keycode_with_modifiers())
	if is_valid_key:
		state_transition.emit(self, "web_aim")
