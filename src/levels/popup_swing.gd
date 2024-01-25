extends Node2D

@onready var animation_player: AnimationPlayer = $animation_player
@onready var key_manager: Node = $key_manager

@export_enum("Swing", "Dash") var tutorial_type: int = 0

var stage: int = 0

# For Tutorial Swing:
var first_key
var second_key

func _ready():
	match tutorial_type:
		0: animation_player.play("press_a")
		1: animation_player.play("press_space")

func _unhandled_input(event: InputEvent):
	match tutorial_type:
		0: progress_swing_tutorial(event)
		1: progress_dash_tutorial(event)

func progress_swing_tutorial(event: InputEvent):
	var key_event := event as InputEventKey
	if not key_event: return
	
	match stage:
		0: set_first_key(key_event)
		1: set_second_key(key_event)
		2: release_first_key(key_event)
		_: kill_tutorial()

func set_first_key(key_event: InputEventKey):
	if not key_event.is_pressed(): return
	var key: int = key_event.get_keycode_with_modifiers()
	var key_location = key_manager.get_key_location(key)
	
	if key_location == key_manager.invalid_location:
		return
	
	first_key = key
	stage = 1
	animation_player.play("press_0")

func set_second_key(key_event: InputEventKey):
	if key_event.is_released() && key_event.get_keycode_with_modifiers() == first_key:
		first_key = null
		stage = 0
		animation_player.play("press_a")
		return
	if key_event.get_keycode_with_modifiers() == first_key: return
	
	var key: int = key_event.get_keycode_with_modifiers()
	var key_location = key_manager.get_key_location(key)
	
	if key_location == key_manager.invalid_location:
		return
	
	second_key = key
	stage = 2
	animation_player.play("release_a")

func release_first_key(key_event: InputEventKey):
	if key_event.is_pressed(): return
	if key_event.get_keycode_with_modifiers() == second_key:
		second_key = null
		stage = 1
		animation_player.play("press_0")
		return
	if not key_event.get_keycode_with_modifiers() == first_key:
		return
	
	stage = 3

func progress_dash_tutorial(event: InputEvent):
	var key_event := event as InputEventKey
	if not key_event: return
	if not key_event.is_pressed(): return
	if key_event.get_keycode_with_modifiers() != KEY_SPACE: return
	
	kill_tutorial()

func kill_tutorial():
	queue_free()
