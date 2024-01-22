extends Node2D

@onready var player: RigidBody2D = $player
@onready var projectiles: Node = $projectiles
@onready var web: Web = $web
@onready var camera: Camera2D = $player/camera

var web_projectile_scene: PackedScene = preload("res://scenes/projectiles/web_projectile.tscn")

func _on_player_spawn_web(pivot_point: Vector2):
	web.shoot_web(player, pivot_point)

func _on_player_swinging(pivot_point: Vector2, web_length: float):
	web.connect_to_body(player, pivot_point, web_length)

func _on_player_dismiss_web():
	camera.offset = Vector2.ZERO
	web.disconnect_from_body()

func _on_player_spawn_web_attack(direction: Vector2):
	var web_projectile = web_projectile_scene.instantiate() as Area2D
	web_projectile.position = player.position
	web_projectile.rotation = direction.angle() + PI/2
	web_projectile.direction = direction
	projectiles.add_child(web_projectile)
