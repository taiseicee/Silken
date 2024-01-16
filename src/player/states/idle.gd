extends State

func enter_state():
	super()
	print("Entered: Idle State")

func process_input(event: InputEvent):
	super(event)
	var key_event := event as InputEventKey
	if not key_event || not event.is_pressed():
		return
	var is_valid_key = movement_comp.set_first_key(key_event.get_keycode_with_modifiers())
	if is_valid_key:
		state_transition.emit(self, "aim")
