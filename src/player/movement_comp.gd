extends Node

var character: CharacterBody2D
@onready
var key_manager: Node = $key_manager

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var first_key: Key
var second_key: Key

var swing_point: Vector2
var web_length: float
var resonant_frequency: float
var beta: float

var angular_vel: float
var angle: float

@export
var mass: float = 1
@export
var air_friction: float = 0.35
@export
var web_length_multiplier: float = 20

func init(character: CharacterBody2D):
	self.character = character

func handle_gravity(delta: float):
	character.velocity.y += gravity * delta

func shoot():
	var first_location: Vector2 = key_manager.get_key_location(first_key)
	var second_location: Vector2 = key_manager.get_key_location(second_key)
	var direction: Vector2 = second_location - first_location
	web_length = (web_length_multiplier * direction).length()
	swing_point = character.position + web_length_multiplier * direction
	resonant_frequency = sqrt(gravity / web_length)
	beta = air_friction / (2 * mass)
	
	angular_vel = 0
	angle = Vector2.DOWN.angle_to(direction)

func swing(delta: float):
	angular_vel = angular_vel + (delta * -2 * beta * angular_vel - (resonant_frequency * resonant_frequency * sin(angle)))
	angle = angle + delta * angular_vel
	
	character.position.y = swing_point.y + web_length * cos(angle) 
	character.position.x = swing_point.x + web_length * sin(angle)

func set_first_key(key: Key) -> bool:
	print("First Key:")
	var location: Vector2 = key_manager.get_key_location(key)
	if not is_valid_key(key, location):
		return false
	first_key = key
	print_key(key)
	return true

func set_second_key(key: Key) -> bool:
	print("Second Key:")
	var location: Vector2 = key_manager.get_key_location(key)
	if not is_valid_key(key, location):
		return false
	second_key = key
	print_key(key)
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
	character.draw_line(character.position, character.to_local(swing_point), Color(1, 1, 1))
