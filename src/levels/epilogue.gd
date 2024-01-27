extends Node2D

@onready var timer_transition: Timer = $timer_transition
var credits: PackedScene = preload("res://scenes/levels/credits.tscn")

func _ready():
	timer_transition.start()

func _on_timer_transition_timeout():
	transition_layer.change_scene(credits)
