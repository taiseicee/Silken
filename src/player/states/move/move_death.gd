extends State

@onready var player_body: Sprite2D = $"../../player_body"
@onready var player_body_dead: Sprite2D = $"../../player_body_dead"
@onready var player_head_dead: Sprite2D = $"../../player_head_dead"

func enter_state():
	super()
	#print("Move Machine > Death State")
	if player_body.flip_h:
		player_body_dead.flip_h = true
		player_head_dead.flip_h = true
		player_head_dead.offset.x *= -1
		player_head_dead.rotation *= -1
		animation_player.play("move_death_right")
		return
	animation_player.play("move_death")
