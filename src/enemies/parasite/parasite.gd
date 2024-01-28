extends "res://src/enemies/enemy_base.gd"

@onready var animation_player: AnimationPlayer = $animation_player

@export var speed_slide_patrol: float = 200
@export var time_anticipate_patrol: float = 2.5

@export var speed_slide_pursue: float = 500
@export var time_anticipate_pursue: float = 1

@export var preferred_slide_distance: float = 200

func _ready():
	health_bar.value = health_max
	health_bar.max_value = health_max
	move_machine.init(self, move_comp, attack_comp, animation_player)
	attack_machine.init(self, move_comp, attack_comp, animation_player)

func take_damage(damage_value: int):
	super(damage_value)
	if health_bar.value > 0: return
	# TODO: Play Death Animation
	#animation_body.play("death")
	#await animation_body.animation_finished
	queue_free()
