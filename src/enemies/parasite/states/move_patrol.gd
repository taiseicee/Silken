extends State

func enter_state():
	super()
	#print("Move Machine > Patrol State")
	movement_comp.set_target_location()

var a = false
func process_physics(_delta: float):
	if not a && movement_comp.ray_cast_forward.get_collider():
		print("collide")
		a = true
	
	movement_comp.ray_cast_down.force_raycast_update()
	if movement_comp.ray_cast_down.is_colliding():
		print("collide")
	#movement_comp.patrol()
