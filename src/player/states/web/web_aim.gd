extends State

@onready var player_head: Sprite2D = $"../../player_head"
@export var head_turn_speed: float = 10

func enter_state():
	super()
	print("Web Machine > Aim State")

func process_frame(delta: float):
	player_head.position = player_head.position.lerp(Vector2.ZERO, delta * head_turn_speed)

func process_input(event: InputEvent):
	if not Input.is_key_pressed(movement_comp.first_key):
		state_transition.emit(self, "web_idle")
		return
	var key_event := event as InputEventKey
	if not key_event || not event.is_pressed():
		return
	if key_event.get_keycode_with_modifiers() == movement_comp.first_key:
		return
	var is_valid_key = movement_comp.set_second_key(key_event.get_keycode_with_modifiers())
	if is_valid_key:
		state_transition.emit(self, "web_shoot")

