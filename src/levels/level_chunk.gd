extends Node2D

@onready var infected_spiders = $infected_spiders
@onready var projectiles = $projectiles

var web_projectile_scene: PackedScene = preload("res://scenes/projectiles/web_projectile.tscn")

signal give_player_dash_tutorial

func _ready():
	for infected_spider in infected_spiders.get_children():
		infected_spider.connect('web_projectile', _on_web_projectile)

func _on_web_projectile(position: Vector2, direction: Vector2, damage: int):
	var web_projectile := web_projectile_scene.instantiate() as Area2D
	web_projectile.position = position
	web_projectile.rotation = direction.angle() + PI/2
	web_projectile.direction = direction
	projectiles.add_child(web_projectile)


func _on_area_2d_body_entered(body):
	if body is Player:
		give_player_dash_tutorial.emit()
