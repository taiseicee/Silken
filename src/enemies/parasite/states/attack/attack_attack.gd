extends State

@onready var timer_attack: Timer = $"../../timer_attack"

func enter_state():
	super()
	#print("Attack Machine > Attack State")
	timer_attack.start()
	animation_player.queue("attack")

func process_frame(_delta: float):
	if not move_comp.is_within_attack_range():
		state_transition.emit(self, "attack_pursuit")
		return
	
	move_comp.attack()

func _on_timer_attack_timeout():
	animation_player.queue("attack")
