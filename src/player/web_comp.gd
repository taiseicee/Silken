extends Node2D

@onready var character: RigidBody2D = $".."
@onready var key_manager: Node = $key_manager
@onready var character_body: Sprite2D = $"../player_body"
@onready var character_head: Sprite2D = $"../player_head"
@onready var timer_dash: Timer = $timer_dash
@onready var timer_dash_persist: Timer = $timer_dash_bar_persist
@onready var dash_hitbox: Area2D = $"../dash_hitbox"
@onready var dash_bar: TextureProgressBar = $dash_bar

@export var web_length_multiplier_x = 30
@export var web_length_multiplier_y = 90

var first_key
var second_key

var web_direction: Vector2
var web_length: float

var can_dash: bool = true

func _ready():
	dash_bar.max_value = timer_dash.wait_time
	dash_bar.value = timer_dash.wait_time

func update_dash_bar():
	if can_dash: return
	dash_bar.value = timer_dash.wait_time - timer_dash.time_left

func shoot():
	var first_key_location = key_manager.get_key_location(first_key)
	var second_key_location = key_manager.get_key_location(second_key)
	var input_vector: Vector2 = second_key_location - first_key_location
	input_vector.x *= web_length_multiplier_x
	input_vector.y *= web_length_multiplier_y
	
	web_length = input_vector.length()
	web_direction = input_vector.normalized()
	character.spawn_web_rope.emit(web_direction, web_length)

func swing():
	character.swing.emit()

func in_shoot_turn(delta):
	var direction_to_web: Vector2 = (web_direction * web_length)
	character_head.flip_h = direction_to_web.x > 0
	character_body.flip_h = direction_to_web.x > 0
	if direction_to_web.x * character_head.offset.x < 0:
		character_head.offset.x *= -1
	var new_head_point: Vector2 = direction_to_web.normalized() * character.head_turn_distance
	character_head.position = character_head.position.lerp(new_head_point, delta * character.head_turn_speed)

func set_first_key(key: Key) -> bool:
	var location: Vector2 = key_manager.get_key_location(key)
	if location == key_manager.invalid_location:
		return false
	first_key = key
	return true

func set_second_key(key: Key) -> bool:
	var location: Vector2 = key_manager.get_key_location(key)
	if location == key_manager.invalid_location:
		return false
	second_key = key
	return true

func dash():
	if not can_dash: return
	dash_bar.visible = true
	can_dash = false
	timer_dash.start()
	dash_hitbox.monitoring = true
	dash_hitbox.monitorable = true
	
	if character.linear_velocity.x < -10:
		character.apply_central_impulse(1000 * Vector2.LEFT)
		return
	elif character.linear_velocity.x > 10:
		character.apply_central_impulse(1000 * Vector2.RIGHT)
		return
	
	if character_body.is_flipped_h():
		character.apply_central_impulse(1000 * Vector2.RIGHT)
	else:
		character.apply_central_impulse(1000 * Vector2.LEFT)

func _on_timer_dash_timeout():
	timer_dash_persist.start()
	can_dash = true
	dash_hitbox.monitoring = false
	dash_hitbox.monitorable = false

func _on_area_dash_body_entered(body):
	if can_dash: return
	if "take_damage" in body:
		body.take_damage(character.dash_damage)

func _on_timer_dash_bar_persist_timeout():
	if not can_dash: return
	dash_bar.visible = false
