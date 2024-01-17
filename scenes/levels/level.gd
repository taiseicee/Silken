extends Node2D

@onready var player: RigidBody2D = $player
@onready var web: DampedSpringJoint2D = $web
@onready var web_end: StaticBody2D = $web_end

func _on_player_dismiss_web():
	web.node_b = web_end.get_path()

func _on_player_spawn_web(pivot_point: Vector2, web_length: float):
	web_end.position = pivot_point
	web.position = pivot_point
	web.rotation = pivot_point.angle_to_point(player.position) - PI/2
	web.length = web_length
	web.rest_length = 1
	web.node_b = player.get_path()
