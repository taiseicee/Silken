extends Node2D

@onready var player: RigidBody2D = $player
@onready var web: Web = $web

func _on_player_spawn_web(pivot_point: Vector2):
	web.shoot_web(player, pivot_point)

func _on_player_swinging(pivot_point: Vector2, web_length: float):
	web.connect_to_body(player, pivot_point, web_length)

func _on_player_dismiss_web():
	web.disconnect_from_body()
