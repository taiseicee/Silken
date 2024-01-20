extends State

@onready var player_head: Sprite2D = $"../../player_head"
@export var head_turn_speed: float = 10

func enter_state():
	super()
	#print("Web Machine > Shoot State")
	movement_comp.shoot()

func process_frame(delta: float):
	var direction_to_web: Vector2 = (movement_comp.web_direction * movement_comp.web_length) + player_head.offset
	player_head.position = player_head.position.lerp(direction_to_web.normalized() * 15, delta * head_turn_speed)

func process_input(_event: InputEvent):
	if Input.is_key_pressed(movement_comp.first_key) && Input.is_key_pressed(movement_comp.second_key):
		character.can_swing = false
		return
	if Input.is_key_pressed(movement_comp.first_key) && not Input.is_key_pressed(movement_comp.second_key):
		character.can_swing = false
		movement_comp.second_key = null
		state_transition.emit(self, "web_aim")
		character.dismiss_web.emit()
		return
	if not Input.is_key_pressed(movement_comp.first_key) && Input.is_key_pressed(movement_comp.second_key):
		# TODO: Make it so the second key becomes the first?
		character.can_swing = true
		return
	if not Input.is_key_pressed(movement_comp.first_key) && not Input.is_key_pressed(movement_comp.second_key):
		character.can_swing = false
		state_transition.emit(self, "web_idle")
		character.dismiss_web.emit()
