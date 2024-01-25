extends State

@onready var timer_attack: Timer = $"../../attack_comp/timer_attack"

func enter_state():
	super()
	#print("Attack Machine > Attack State")
	timer_attack.start()

func process_frame(_delta: float):
	if not action_comp.should_pursue():
		state_transition.emit(self, "attack_patrol")
		return
	
	if action_comp.can_attack:
		animation_player.queue("attack_shoot")
	action_comp.attack()
