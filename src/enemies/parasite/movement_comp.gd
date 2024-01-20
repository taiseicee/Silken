extends Node

@onready var character: CharacterBody2D = $".."

@export var speed_patrol: float = 30

var direction: float = -1

func patrol():
	if character.is_on_wall() || not character.is_on_floor():
		direction *= -1
	character.velocity.x = direction * speed_patrol
	character.move_and_slide()
