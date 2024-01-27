extends RigidBody2D

@onready var i_frames: Timer = $i_frames

var can_be_picked_up = false

func _ready():
	i_frames.start()

func _on_area_2d_body_entered(body):
	if not can_be_picked_up: return
	if "collect_cocoon" in body:
		body.collect_cocoon()
	queue_free()

func _on_i_frames_timeout():
	can_be_picked_up = true
