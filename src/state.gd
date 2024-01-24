# A template for the states the state manager manages
extends Node
class_name State

var character: PhysicsBody2D
var move_comp: Node
var action_comp: Node
var animation_player: AnimationPlayer

signal state_transition

func enter_state():
	pass

func exit_state():
	if animation_player:
		animation_player.stop()
		animation_player.clear_queue()

func process_frame(_delta: float):
	pass

func process_input(_event: InputEvent):
	pass

func process_physics(_delta: float):
	pass
