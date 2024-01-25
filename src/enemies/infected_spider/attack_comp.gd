extends "res://src/enemies/base/attack_comp.gd"

func attack():
	if not can_attack: return
	if not character.player: return
	timer_attack.start()
	can_attack = false
	
	var web_direction: Vector2 = (character.player.global_position - character.global_position).normalized()
	character.web_projectile.emit(character.global_position, web_direction, character.base_attack_damage)
