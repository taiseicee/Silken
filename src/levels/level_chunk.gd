extends Node2D

@onready var infected_spiders = $infected_spiders
@onready var parasites = $parasites
@onready var projectiles = $projectiles
@onready var cocoons = $cocoons
@onready var dialog_sequences = $dialog_sequences

@export var thorn_damage = 10
@export var player: PhysicsBody2D
@export var camera: Camera2D

var web_projectile_scene: PackedScene = preload("res://scenes/projectiles/web_projectile.tscn")
var cocoon_scene: PackedScene = preload("res://scenes/items/cocoon.tscn")

func _ready():
	for infected_spider in infected_spiders.get_children():
		infected_spider.connect('web_projectile', _on_web_projectile)
		infected_spider.connect("dead", _on_enemy_death)
		
	for parasite in parasites.get_children():
		parasite.connect("dead", _on_enemy_death)
	
	for dialog in dialog_sequences.get_children():
		dialog.player = player
		dialog.camera = camera

func _on_web_projectile(character_position: Vector2, direction: Vector2, _damage: int):
	var web_projectile := web_projectile_scene.instantiate() as Area2D
	web_projectile.position = character_position
	web_projectile.rotation = direction.angle() + PI/2
	web_projectile.direction = direction
	projectiles.add_child(web_projectile)

func _on_enemy_death(enemy_position: Vector2):
	var cocoon := cocoon_scene.instantiate() as RigidBody2D
	var buffer: Vector2 = Vector2.UP * 10
	cocoons.add_child(cocoon)
	cocoon.global_position = enemy_position + buffer
	cocoon.apply_central_impulse(Vector2.UP * 100)

func _on_thorns_hitbox_body_entered(body):
	if body is Player:
		globals.add_player_health(-thorn_damage)
