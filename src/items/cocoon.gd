extends RigidBody2D

func _on_area_2d_body_entered(body):
	if "collect_cocoon" in body:
		body.collect_cocoon()
	queue_free()
