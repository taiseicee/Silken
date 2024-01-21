extends Node

@onready var character: CharacterBody2D = $".."
@onready var ray_cast_forward: RayCast2D = $"../ray_cast_forward"
@onready var ray_cast_down: RayCast2D = $"../ray_cast_down"

@export var speed_patrol: float = 200
@export var slide_distance: float = 150
@export var max_descent_angle: float = 75 * PI/180
@export var ray_cast_buffer: float = 10

@export var direction: float = -1
var target_position: Vector2 = Vector2.ZERO

func should_change_direction() -> bool:
	target_position = Vector2(direction * slide_distance, 0)
	ray_cast_forward.target_position = target_position
	if ray_cast_forward.is_colliding():
		print(character.name + " Found Wall")
		return true
	
	ray_cast_down.position = target_position
	var down_target_position = Vector2(0, sin(max_descent_angle))
	var multiplier = slide_distance / cos(max_descent_angle)
	ray_cast_down.target_position = multiplier * down_target_position
	
	print(ray_cast_down.target_position)
	print(ray_cast_down.position)
	
	if not ray_cast_down.is_colliding():
		print(character.name + " Found Fall")
		return true
	
	return false

func change_direction():
	direction *= -1

func patrol():
	# TODO: Implement this better
	var did_change_direction: bool = false
	if character.is_on_wall() || not character.is_on_floor():
		did_change_direction = true
		direction *= -1
	
	character.velocity.x = direction * speed_patrol
	if did_change_direction:
		character.velocity.x *= 1.5
	character.move_and_slide()
