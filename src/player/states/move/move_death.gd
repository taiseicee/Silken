extends State

func enter_state():
	super()
	#print("Move Machine > Death State")
	animation_player.queue("move_death")
