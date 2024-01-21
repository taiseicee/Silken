extends Node2D

@onready var character: CharacterBody2D = $".."
@onready var ray_cast_left: RayCast2D = $ray_cast_left
@onready var ray_cast_right: RayCast2D = $ray_cast_right

@export var speed_slide: float = 200
@export var preferred_slide_distance: float = 150
@export var max_descent_angle: float = 75 * PI/180

@export var direction: float = -1
var slide_start_position: Vector2

var can_anticipate: bool = false

func init():
	var target_multiplier: float = abs(ray_cast_left.position.x / cos(max_descent_angle))
	ray_cast_left.target_position = Vector2(0, sin(max_descent_angle))
	ray_cast_left.target_position *= target_multiplier
	ray_cast_right.target_position = ray_cast_left.target_position
	
	slide_start_position = character.position

func change_direction():
	direction *= -1
	slide_start_position = character.position

func slide(delta):
	if slide_start_position.distance_to(character.position) <= preferred_slide_distance:
		#character.velocity.x = lerp(character.velocity.x, 10.0, direction * 0.1)
		character.velocity.x = direction * speed_slide
	else:
		slide_start_position = character.position
		character.velocity.x = 0
		can_anticipate = true
		
	character.move_and_slide()
	
	if character.is_on_wall(): 
		can_anticipate = true
		change_direction()
		return
	
	if direction < 0 && not ray_cast_left.is_colliding():
		can_anticipate = true
		change_direction()
		return
	
	if direction > 0 && not ray_cast_right.is_colliding():
		can_anticipate = true
		change_direction()
		return

func should_anticipate() -> bool:
	if can_anticipate:
		can_anticipate = false
		return true
	return false
