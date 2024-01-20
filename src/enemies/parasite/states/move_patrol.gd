extends State

func enter_state():
	super()
	#print("Move Machine > Patrol State")

func process_physics(_delta: float):
	movement_comp.patrol()
