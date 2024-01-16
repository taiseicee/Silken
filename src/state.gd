# A template for the states the state manager manages
class_name State
extends Node

var character: CharacterBody2D
var movement_comp: Node

func enter_state():
	pass

func exit_state():
	pass

func process_frame(_delta: float) -> State:
	return null

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
