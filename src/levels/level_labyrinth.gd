extends "res://src/levels/level_chunk.gd"

signal give_player_dash_tutorial

var epilogue_scene: PackedScene = preload("res://scenes/levels/epilogue.tscn")

func _on_area_2d_body_entered(body):
	if body is Player: give_player_dash_tutorial.emit()

func _on_dialog_queen_finished_dialog():
	transition_layer.change_scene(epilogue_scene)
