extends "res://src/enemies/base/attack_comp.gd"

func attack():
	if not can_attack: return
	if not character.player: return
	timer_attack.start()
	can_attack = false
	
	var direction_to_player: Vector2 = character.player.global_position - character.global_position
	
	if direction_to_player.x * character.direction < 0:
		character.move_comp.change_direction()
	
	var web_direction: Vector2 = (character.player.global_position - character.global_position).normalized()
	character.web_projectile.emit(character.global_position, web_direction, character.base_attack_damage)
