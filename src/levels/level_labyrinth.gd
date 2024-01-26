extends "res://src/levels/level_chunk.gd"

@export var thorn_damage = 10

signal give_player_dash_tutorial

func _on_area_2d_body_entered(body):
	if body is Player:
		give_player_dash_tutorial.emit()

func _on_thorns_hit_box_body_entered(body):
	if body is Player:
		globals.add_player_health(-thorn_damage)
