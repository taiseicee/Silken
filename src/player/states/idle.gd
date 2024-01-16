extends State

func enter_state():
	super()
	print("Entered: Idle State")

func process_frame(delta: float):
	super(delta)
	return null

func process_input(event: InputEvent):
	super(event)
	return null

func process_physics(delta: float):
	super(delta)
	return null
