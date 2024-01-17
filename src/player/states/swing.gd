extends State

func enter_state():
	super()
	print("Entered: Swing State")

func process_input(event: InputEvent):
	super(event)
	# TODO: Add switching of first and second keys

func process_physics(delta: float):
	super(delta)
	movement_comp.swing(delta)
