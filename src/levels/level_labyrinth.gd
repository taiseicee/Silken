extends "res://src/levels/level_chunk.gd"

signal give_player_dash_tutorial

func _on_area_2d_body_entered(body):
	if body is Player:
		give_player_dash_tutorial.emit()
