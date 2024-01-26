extends Node2D

@onready var timer_transition: Timer = $timer_transition
var game: PackedScene = preload("res://scenes/levels/level_master.tscn")

func _ready():
	timer_transition.start()

func _on_timer_transition_timeout():
	transition_layer.change_scene(game)
