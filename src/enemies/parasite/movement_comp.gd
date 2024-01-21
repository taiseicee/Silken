extends Node2D

@onready var character: CharacterBody2D = $".."
@onready var timer_release: Timer = $"../timer_release"
@onready var timer_attack: Timer = $"../timer_attack"
@onready var ray_cast_left: RayCast2D = $ray_cast_left
@onready var ray_cast_right: RayCast2D = $ray_cast_right
@onready var ray_cast_vision: RayCast2D = $ray_cast_vision

@export var speed_slide_patrol: float = 200
@export var time_anticipate_patrol: float = 2.5

@export var speed_slide_pursuit: float = 500
@export var time_anticipate_pursuit: float = 1

@export var preferred_slide_distance: float = 150
@export var max_descent_angle: float = 75 * PI/180

@export var attack_range: float = 100
@export var attack_damage: int = 10

@export var direction: float = -1
var speed_slide: float = 200
var slide_start_position: Vector2

var can_anticipate: bool = false
var can_attack: bool = true

var player

func init():
	var target_multiplier: float = abs(ray_cast_left.position.x / cos(max_descent_angle))
	ray_cast_left.target_position = Vector2(0, sin(max_descent_angle))
	ray_cast_left.target_position *= target_multiplier
	ray_cast_right.target_position = ray_cast_left.target_position
	
	slide_start_position = character.position

func init_patrol():
	speed_slide = speed_slide_patrol
	timer_release.wait_time = time_anticipate_patrol

func init_pursuit():
	speed_slide = speed_slide_pursuit
	timer_release.wait_time = time_anticipate_pursuit

func change_direction():
	direction *= -1
	slide_start_position = character.position

func slide_patrol():
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
	
func slide_pursuit():
	if not player:
		slide_start_position = character.position
		can_anticipate = true
		return
	
	if (player.global_position.x - character.global_position.x) * direction < 0:
		can_anticipate = true
		change_direction()
		return
	
	if slide_start_position.distance_to(character.position) <= preferred_slide_distance:
		#character.velocity.x = lerp(character.velocity.x, 10.0, direction * 0.1)
		character.velocity.x = direction * speed_slide
	else:
		slide_start_position = character.position
		character.velocity.x = 0
		can_anticipate = true
		
	character.move_and_slide()

func should_pursue() -> bool:
	if not player:
		return false
	
	ray_cast_vision.target_position = player.global_position - character.global_position
	
	if not ray_cast_vision.is_colliding():
		return false
	
	if ray_cast_vision.get_collider() is Player:
		return true
	
	return false

func is_within_attack_range():
	if not player:
		return false
	if abs(player.global_position.x - character.global_position.x) <= attack_range:
		return true
	return false

func attack():
	if not can_attack:
		return
	timer_attack.start()
	can_attack = false
	globals.health -= attack_damage
	print(globals.health)

func _on_vision_body_entered(body: Node2D):
	player = body

func _on_vision_body_exited(_body: Node2D):
	player = null

func _on_timer_attack_timeout():
	can_attack = true
