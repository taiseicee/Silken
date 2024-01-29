extends Node2D
class_name DialogForced

@onready var hitbox: Area2D = $dialog_queue_hitbox

@export var text_box: TextBox
@export var speaker: Node2D
@export var camera: Camera2D
@export var player: PhysicsBody2D

var dialog_stage: int = 0
var dialog = []
var is_playing: bool = false

signal finished_dialog

func _process(delta):
	if not is_playing: return
	camera.global_position = speaker.global_position
	if Input.is_action_just_pressed("interact"):
		progress_dialog()

func _on_dialog_queue_hitbox_body_entered(body):
	if not body is Player: return
	hitbox.queue_free()
	globals.is_in_cutscene = true
	is_playing = true
	text_box.visible = true
	progress_dialog()

func exit_narrative():
	camera.global_position = player.global_position
	text_box.visible = false
	is_playing = false
	globals.is_in_cutscene = false
	finished_dialog.emit()
	queue_free()

func progress_dialog():
	if dialog_stage < dialog.size():
		text_box.set_text(dialog[dialog_stage])
		dialog_stage += 1
	else:
		exit_narrative()
	
