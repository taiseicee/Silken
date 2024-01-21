extends Node

@onready var character: CharacterBody2D = $".."
@onready var ray_cast_forward: RayCast2D = $"../ray_cast_forward"
@onready var ray_cast_down: RayCast2D = $"../ray_cast_down"

@export var speed_slide: float = 200
@export var slide_distance: float = 150
@export var max_descent_angle: float = 75 * PI/180

@export var direction: float = -1
var target_position: Vector2 = Vector2.ZERO
var start_position_x: float

var can_anticipate: bool = false

func should_change_direction() -> bool:
	target_position = Vector2(direction * slide_distance, 0)
	ray_cast_forward.target_position = target_position
	start_position_x = character.position.x
	
	if ray_cast_forward.is_colliding():
		#print(character.name + " Found Wall")
		return true
	
	ray_cast_down.position = target_position
	var down_target_position = Vector2(0, sin(max_descent_angle))
	var multiplier = slide_distance / cos(max_descent_angle)
	ray_cast_down.target_position = multiplier * down_target_position
	
	if not ray_cast_down.is_colliding():
		#print(character.name + " Found Fall")
		return true
	
	return false

func change_direction():
	direction *= -1
	target_position = Vector2(direction * slide_distance, 0)
	start_position_x = character.position.x

func slide(delta):
	var progress: float = (character.position.x - start_position_x) / target_position.x
	if progress <= 0.5:
		can_anticipate = false
		#character.velocity.x = lerp(character.velocity.x, direction * speed_slide, 0.1)
		character.velocity.x = direction * speed_slide
	elif progress <= 1:
		#character.velocity.x = lerp(character.velocity.x, 10.0, direction * 0.1)
		character.velocity.x = direction * speed_slide
	else:
		character.velocity.x = 0
		can_anticipate = true
	
	character.move_and_slide()

func should_anticipate() -> bool:
	if can_anticipate:
		can_anticipate = false
		return true
	return false
