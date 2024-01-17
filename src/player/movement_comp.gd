extends Node

var character: CharacterBody2D
var key_manager: Node

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var first_key
var second_key

var web_direction: Vector2
var web_length: float
@export var web_length_multiplier = 30
@export var mass: float = 1

func init(character: CharacterBody2D, key_manager: Node):
	self.character = character
	self.key_manager = key_manager

func shoot():
	var first_key_location = key_manager.get_key_location(first_key)
	var second_key_location = key_manager.get_key_location(second_key)
	var input_vector: Vector2 = web_length_multiplier * (second_key_location - first_key_location)
	
	web_length = input_vector.length()
	web_direction = input_vector.normalized()

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

func draw_web():
	if web_direction && web_length:
		character.draw_line(Vector2.ZERO, web_length * web_direction, Color(1,1,1,1), 5)
