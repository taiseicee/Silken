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

#func _on_player_spawn_web_attack(direction: Vector2):
	#var web_projectile = web_projectile_scene.instantiate() as Area2D
	#web_projectile.position = player.position
	#web_projectile.rotation = direction.angle() + PI/2
	#web_projectile.direction = direction
	#projectiles.add_child(web_projectile)
