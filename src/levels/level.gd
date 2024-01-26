extends Node2D

@onready var player: RigidBody2D = $player
@onready var projectiles: Node = $projectiles
@onready var web: Web = $web
@onready var ui: CanvasLayer = $user_interface

var web_projectile_scene: PackedScene = preload("res://scenes/projectiles/web_projectile.tscn")

func _ready():
	globals.ui = ui

func _on_player_spawn_web_rope(web_direction, web_length):
	var pivot_point = player.global_position + web_length * web_direction
	web.shoot_web(player, pivot_point)

func _on_player_swing():
	web.connect_to_body(player)

func _on_player_dismiss_web():
	web.disconnect_from_body()

func _on_player_death():
	transition_layer.end_scene()
	player.reset()
	transition_layer.start_scene()
