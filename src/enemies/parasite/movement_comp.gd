extends Node

@onready var character: CharacterBody2D = $".."
@onready var ray_cast_forward: RayCast2D = $"../ray_cast_forward"
@onready var ray_cast_down: RayCast2D = $"../ray_cast_down"

@export var speed_patrol: float = 200
@export var slide_distance: float = 500
@export var max_descent_angle: float = 75 * PI/180
@export var ray_cast_buffer: float = 10

var direction: float = -1
var target_point: Vector2 = Vector2.ZERO

func set_target_location():
	pass

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
