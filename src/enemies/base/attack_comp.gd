extends Node2D

@onready var character: CharacterBody2D = $".."
@onready var timer_attack: Timer = $timer_attack
@onready var line_of_sight: RayCast2D = $line_of_sight

var can_attack: bool = false

func should_pursue() -> bool:
	if not character.player: return false
	
	line_of_sight.target_position = character.player.global_position - character.global_position
	
	if not line_of_sight.is_colliding(): return false
	if line_of_sight.get_collider() is Player: return true
	return false

func is_within_attack_range():
	if not character.player: return false
	var distance_to_player = character.global_position.distance_to(character.player.global_position)
	if distance_to_player <= character.attack_range: return true
	return false

func attack():
	if not can_attack or not is_within_attack_range(): return
	timer_attack.start()
	can_attack = false
	globals.add_player_health(-character.base_attack_damage)

func _on_timer_attack_timeout():
	can_attack = true
