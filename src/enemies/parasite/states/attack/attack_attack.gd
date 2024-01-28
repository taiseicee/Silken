extends State

@onready var timer_attack: Timer = $"../../attack_comp/timer_attack"

func enter_state():
	super()
	#print("Attack Machine > Attack State")
	timer_attack.start()
	animation_player.queue("attack")

func process_frame(delta: float):
	super(delta)
	if not action_comp.is_within_attack_range():
		state_transition.emit(self, "attack_alert")
		return
	
	action_comp.attack()

func _on_timer_attack_timeout():
	animation_player.queue("attack")
