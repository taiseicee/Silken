extends Node

@onready var character: CharacterBody2D = $".."

@export var speed_patrol: float = 200

var direction: float = -1

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
