extends Node2D

@onready var character: RigidBody2D = $".."
@onready var key_manager: Node = $key_manager

@onready var character_body: Sprite2D = $"../player_body"
@onready var character_head: Sprite2D = $"../player_head"
@onready var ray_cast_down: RayCast2D = $ray_cast_down
@onready var timer_attack: Timer = $timer_attack

@export var web_length_multiplier_x = 30
@export var web_length_multiplier_y = 90

@export var head_turn_speed: float = 10
@export var head_turn_distance: float = 10

var first_key
var second_key

var web_direction: Vector2
var web_length: float
var pivot_point: Vector2

var can_attack: bool = true

func attack():
	if not can_attack:
		return
	can_attack = false
	timer_attack.start()
	var direction_attack: Vector2 = get_global_mouse_position() - character.global_position
	character.spawn_web_attack.emit(direction_attack.normalized())

func shoot():
	var first_key_location = key_manager.get_key_location(first_key)
	var second_key_location = key_manager.get_key_location(second_key)
	var input_vector: Vector2 = second_key_location - first_key_location
	input_vector.x *= web_length_multiplier_x
	input_vector.y *= web_length_multiplier_y
	
	web_length = input_vector.length()
	web_direction = input_vector.normalized()
	pivot_point = character.global_position + web_length * web_direction
	character.spawn_web.emit(pivot_point)
	
func swing():
	character.swinging.emit(pivot_point, web_length)
	character.gravity_scale = 1

func in_shoot_turn(delta):
	var direction_to_web: Vector2 = (web_direction * web_length)
	character_head.flip_h = direction_to_web.x > 0
	character_body.flip_h = direction_to_web.x > 0
	if direction_to_web.x * character_head.offset.x < 0:
		character_head.offset.x *= -1
	character_head.position = character_head.position.lerp(direction_to_web.normalized() * head_turn_distance, delta * head_turn_speed)

func in_swing_turn(delta):
	character_head.flip_h = character.linear_velocity.x > 0
	character_body.flip_h = character.linear_velocity.x > 0
	if character.linear_velocity.x * character_head.offset.x < 0:
		character_head.offset.x *= -1
	character_head.position = character_head.position.lerp(Vector2.ZERO, delta * head_turn_speed)

func head_return(delta):
	character_head.position = character_head.position.lerp(Vector2.ZERO, delta * head_turn_speed)

func is_on_floor() -> bool:
	return ray_cast_down.is_colliding()

func set_first_key(key: Key) -> bool:
	#print("First Key:")
	var location: Vector2 = key_manager.get_key_location(key)
	if not is_valid_key(key, location):
		return false
	first_key = key
	#print_key(key)
	return true

func set_second_key(key: Key) -> bool:
	#print("Second Key:")
	var location: Vector2 = key_manager.get_key_location(key)
	if not is_valid_key(key, location):
		return false
	second_key = key
	#print_key(key)
	return true

func is_valid_key(key: Key, location: Vector2):
	if location == Vector2(-1, -1):
		print("WARNING: Invalid Key: %c - %d" % [key, key])
		return false
	return true

func print_key(key: Key):
	var location: Vector2 = key_manager.get_key_location(key)
	if is_valid_key(key, location):
		print("%c - %d - %v" % [key, key, location])

func _on_timer_attack_timeout():
	can_attack = true
