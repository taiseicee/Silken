extends State

func enter_state():
	super()
	#print("Move Machine > Idle State")

func process_frame(delta: float):
	super(delta)
	if not character.is_on_floor():
		state_transition.emit(self, "move_fall")
		return
	
	# TODO: Implement walk - Needs aniamtion
	#if character.attack_machine.is_in_state("attack_patrol"):
		#animation_player.queue("move_patrol")
		#move_comp.patrol()
		#return
