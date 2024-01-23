extends Node2D

@onready var character: RigidBody2D = $".."
@onready var character_body: Sprite2D = $"../player_body"
@onready var character_head: Sprite2D = $"../player_head"
@onready var ray_cast_down_right: RayCast2D = $ray_cast_down_right
@onready var ray_cast_down_left: RayCast2D = $ray_cast_down_left

func in_swing_turn(delta):
	if  -5 < character.linear_velocity.x and character.linear_velocity.x < 5:
		return
	character_head.flip_h = character.linear_velocity.x > 0
	character_body.flip_h = character.linear_velocity.x > 0
	if character.linear_velocity.x * character_head.offset.x < 0:
		character_head.offset.x *= -1
	character_head.position = character_head.position.lerp(Vector2.ZERO, delta * character.head_turn_speed)

func head_return(delta):
	character_head.position = character_head.position.lerp(Vector2.ZERO, delta * character.head_turn_speed)

func is_on_floor() -> bool:
	return ray_cast_down_right.is_colliding() or ray_cast_down_left.is_colliding()
