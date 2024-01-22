extends Area2D

@onready var timer_destruct: Timer = $timer_destruct

@export var speed: float = 1000
@export var damage: int = 10

var direction: Vector2 = Vector2.UP

func _ready():
	timer_destruct.start()

func _process(delta):
	position += speed * direction * delta

func _on_body_entered(body):
	if "take_damage" in body:
		body.take_damage(damage)
	queue_free()

func _on_timer_destruct_timeout():
	queue_free()
