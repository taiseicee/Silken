# A template for the states the state manager manages
extends Node
class_name State

var character: RigidBody2D
var movement_comp: Node

signal state_transition

func enter_state():
	pass

func exit_state():
	pass

func process_frame(_delta: float):
	pass

func process_input(_event: InputEvent):
	pass

func process_physics(_delta: float):
	pass
