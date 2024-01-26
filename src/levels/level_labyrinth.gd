extends "res://src/levels/level_chunk.gd"

@export var thorn_damage = 10

signal give_player_dash_tutorial

@onready var text_box: CanvasLayer = $text_box

var camera: Camera2D
var dialogue_stage = 0

func _process(delta):
	if not globals.is_in_cutscene: return
	if Input.is_action_just_pressed("interact"):
		dialogue_stage += 1
		match dialogue_stage:
			1: text_box.set_text("Queen Aria's cocoons have been stolen by parasitic beasts. Please kill them and take what is rightfully hers back to the nest.")
			2: text_box.set_text("I must stand guard for now. Hurry. I hate to see her cocoons being abused in such manner.")
			3: resume_game()

func _on_area_2d_body_entered(body):
	if body is Player:
		give_player_dash_tutorial.emit()

func _on_thorns_hit_box_body_entered(body):
	if body is Player:
		globals.add_player_health(-thorn_damage)

func _on_narrative_1_body_entered(body):
	if not body is Player: return
	globals.is_in_cutscene = true
	text_box.visible = true
	camera.position.x -= 1000
	text_box.set_text("Ahhh. I guess I did feel a Silken's presence nearby. Tell me are the others around?")

func resume_game():
	camera.position.x += 1000
	text_box.visible = false
	globals.is_in_cutscene = false
