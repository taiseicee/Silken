extends "res://src/enemies/base/states/attack/attack_patrol.gd"

func enter_state():
	super()
	#print("Attack Machine > Patrol State")
	move_comp.init_patrol()
