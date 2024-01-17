extends Node2D

@onready var player: RigidBody2D = $player
@onready var web: DampedSpringJoint2D = $web
@onready var web_end: StaticBody2D = $web_end

func _on_player_dismiss_web():
	web.node_b = web_end.get_path()

func _on_player_spawn_web(pivot_point: Vector2, length: float):
	web_end.position = pivot_point
	web.position = pivot_point
	web.length = length
	web.node_b = player.get_path()
