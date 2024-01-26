extends RigidBody2D

@onready var player_check_left: RayCast2D = $player_check_left
@onready var player_check_right: RayCast2D = $player_check_right

var is_falling = false
var damage: int = 20

func _physics_process(delta):
	if not player_check_left.is_colliding() and not player_check_right.is_colliding() : return
	if player_check_left.get_collider() is Player or player_check_right.get_collider() is Player:
		gravity_scale = 1
		is_falling = true

func _on_hit_box_body_entered(body):
	if not is_falling: return
	if body is Player:
		globals.add_player_health(-damage)
	queue_free()
