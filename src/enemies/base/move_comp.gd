extends Node2D

@onready var character: CharacterBody2D = $".."
@onready var ray_cast_left: RayCast2D = $ray_cast_left
@onready var ray_cast_right: RayCast2D = $ray_cast_right

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func patrol():
	character.velocity.x = character.direction * character.base_speed
	character.move_and_slide()
	
	if character.is_on_wall():
		change_direction()
		return
	
	if character.direction < 0 && not ray_cast_left.is_colliding():
		change_direction()
		return
	
	if character.direction > 0 && not ray_cast_right.is_colliding():
		change_direction()
		return

func pursue():
	if not character.player: return
	
	if (character.player.global_position.x - character.global_position.x) * character.direction < 0:
		change_direction()
		return
	
	character.velocity.x = character.direction * character.base_speed * character.pusue_speed_multiplier
	character.move_and_slide()

func change_direction():
	character.direction *= -1

func handle_gravity(delta: float):
	character.velocity.y += gravity * delta
	character.move_and_slide() 
