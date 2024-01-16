extends Node

var character: CharacterBody2D
var key_manager: Node

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var first_key: Key
var second_key: Key

func init(character: CharacterBody2D, key_manager: Node):
	self.character = character
	self.key_manager = key_manager

func print_key(key: Key):
	var location: Vector2 = key_manager.get_key_location(key)
	if location != Vector2(-1, -1):
		print("%c - %d - %v" % [key, key, location])
		return
	print("Invalid key")
