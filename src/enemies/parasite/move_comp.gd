extends "res://src/enemies/base/move_comp.gd"

@onready var sprite: Sprite2D = $"../sprite"
@onready var timer_release: Timer = $timer_release

var speed_slide: float = 500
var slide_start_position: Vector2
var can_anticipate = false

func init_patrol():
	speed_slide = character.speed_slide_patrol
	timer_release.wait_time = character.time_anticipate_patrol

func init_pursuit():
	speed_slide = character.speed_slide_pursue
	timer_release.wait_time = character.time_anticipate_pursue

func change_direction():
	super()
	sprite.flip_h = character.direction > 0
	slide_start_position = character.position

func slide_patrol():
	if slide_start_position.distance_to(character.position) <= character.preferred_slide_distance:
		#character.velocity.x = lerp(character.velocity.x, 10.0, direction * 0.1)
		character.velocity.x = character.direction * speed_slide
	else:
		slide_start_position = character.position
		character.velocity.x = 0
		can_anticipate = true
		
	character.move_and_slide()
	
	if character.is_on_wall(): 
		can_anticipate = true
		change_direction()
		return
	
	if character.direction < 0 && not ray_cast_left.is_colliding():
		can_anticipate = true
		change_direction()
		return
	
	if character.direction > 0 && not ray_cast_right.is_colliding():
		can_anticipate = true
		change_direction()
		return
	
func slide_pursuit():
	if not character.player:
		slide_start_position = character.position
		can_anticipate = true
		return
	
	if (character.player.global_position.x - character.global_position.x) * character.direction < 0:
		can_anticipate = true
		change_direction()
		return
	
	if slide_start_position.distance_to(character.position) <= character.preferred_slide_distance:
		#character.velocity.x = lerp(character.velocity.x, 10.0, direction * 0.1)
		character.velocity.x = character.direction * speed_slide
	else:
		slide_start_position = character.position
		character.velocity.x = 0
		can_anticipate = true
		
	character.move_and_slide()
