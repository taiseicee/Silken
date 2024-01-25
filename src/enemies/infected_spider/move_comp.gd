extends "res://src/enemies/base/move_comp.gd"

@onready var character_head: Sprite2D = $"../sprite_head"
@onready var character_body: Sprite2D = $"../sprite_body"

func change_direction():
	character.direction *= -1
	
	character_head.flip_h = character.direction > 0
	character_body.flip_h = character.direction > 0
	if character.direction * character_head.offset.x < 0:
		character_head.offset.x *= -1
