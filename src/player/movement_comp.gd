extends Node

@onready var character: RigidBody2D = $".."
@onready var key_manager: Node = $key_manager

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var first_key
var second_key

var web_direction: Vector2
var web_length: float
var pivot_point: Vector2
@export var web_length_multiplier_x = 30
@export var web_length_multiplier_y = 90
@export var mass: float = 1

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

func is_on_floor() -> bool:
	return false

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
