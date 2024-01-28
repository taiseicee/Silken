extends Node2D

@onready var hitbox: Area2D = $dialog_queue_hitbox

@export var text_box: TextBox
@export var camera: Camera2D
@export var speaker: Node2D
@export var player: PhysicsBody2D

var dialog_stage: int = 0
var dialog = [""]

signal finished_dialog

func _process(delta):
	if not globals.is_in_cutscene: return
	camera.global_position = speaker.global_position
	if Input.is_action_just_pressed("interact"):
		text_box.set_text(dialog[dialog_stage])
		dialog_stage += 1
	if dialog_stage >= dialog.size():
		exit_narrative()

func _on_dialog_queue_hitbox_body_entered(body):
	if not body is Player: return
	hitbox.queue_free()
	globals.is_in_cutscene = true
	text_box.visible = true
	text_box.set_text(dialog[dialog_stage])

func exit_narrative():
	camera.global_position = player.global_position
	text_box.visible = false
	globals.is_in_cutscene = false
	queue_free()
