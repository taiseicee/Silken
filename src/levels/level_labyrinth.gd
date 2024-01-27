extends "res://src/levels/level_chunk.gd"

@export var thorn_damage = 10

signal give_player_dash_tutorial

@onready var text_box: CanvasLayer = $text_box

var camera: Camera2D
var dialogue_stage = 0
var epilogue_scene: PackedScene = preload("res://scenes/levels/epilogue.tscn")

func _process(delta):
	if not globals.is_in_cutscene: return
	if Input.is_action_just_pressed("interact"):
		dialogue_stage += 1
		match dialogue_stage:
			1: text_box.set_text("Queen Aria's cocoons have been stolen by parasitic beasts. Please kill them and take what is rightfully hers back to the nest.")
			2: text_box.set_text("I must stand guard for now. Hurry. I hate to see Queen Aria's cocoons being abused in such manner.")
			3: exit_narrative_1()
			4: narrative_1_branch_1()
			5: text_box.set_text("While you are but a new born, I ask of you to please help your Silk-kin.")
			6: exit_narrative_2()

func _on_area_2d_body_entered(body):
	if body is Player:
		give_player_dash_tutorial.emit()

func _on_thorns_hit_box_body_entered(body):
	if body is Player:
		globals.add_player_health(-thorn_damage)

func _on_narrative_1_body_entered(body):
	if not body is Player: return
	$narrative_1_hit_box.queue_free()
	globals.is_in_cutscene = true
	text_box.visible = true
	camera.position.x -= 1000
	text_box.set_text("Ahhh. I guess I did feel a Silken's presence nearby. Tell me are the others around?")

func exit_narrative_1():
	camera.position.x += 1000
	text_box.visible = false
	globals.is_in_cutscene = false

func _on_narrative_2_hit_box_body_entered(body):
	if not body is Player: return
	$narrative_2_hit_box.queue_free()
	globals.is_in_cutscene = true
	text_box.visible = true
	camera.position.x += 500
	text_box.set_text("Oh? You're Silk Given arn't you? Your presence is reassuing.")
	pass # Replace with function body.

func narrative_1_branch_1():
	var text = "You have collected "
	if globals.cocoon_count == 1:
		text += "1 cocoon so far..."
	else:
		text += str(globals.cocoon_count) + " of my cocoons so far... "
	if globals.cocoon_count <= 0:
		text += "Hmm. Well I guess your survival is what is most important."
	elif globals.cocoon_count < 3:
		text += "Good Work, Silken Warrior!"
	else:
		text += "Excellent Work, Silken Warrior! Your skills are very promising indeed."
	
	text_box.set_text(text)

func exit_narrative_2():
	camera.position.x -= 500
	text_box.visible = false
	globals.is_in_cutscene = false
	transition_layer.change_scene(epilogue_scene)
