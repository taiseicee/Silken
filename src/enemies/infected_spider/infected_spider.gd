extends "res://src/enemies/enemy_base.gd"

@onready var animation_body: AnimationPlayer = $animation_body
@onready var animation_head: AnimationPlayer = $animation_head

signal web_projectile(position, direction, damage)

func _ready():
	health_bar.value = health_max
	health_bar.max_value = health_max
	move_machine.init(self, move_comp, attack_comp, animation_body)
	attack_machine.init(self, move_comp, attack_comp, animation_head)

func take_damage(damage_value: int):
	super(damage_value)
	if health_bar.value > 0: return
	animation_body.play("death")
	await animation_body.animation_finished
	queue_free()
