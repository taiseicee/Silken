extends StaticBody2D

@export var min_speed_to_budge: float = 300

func take_damage(damage: int):
	queue_free()

func _on_area_hit_body_entered(body):
	if not body is PhysicsBody2D: return
	if body.linear_velocity.length() >= min_speed_to_budge:
		print("shake")
