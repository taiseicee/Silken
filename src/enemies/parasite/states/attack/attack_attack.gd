extends State

@onready var timer_attack: Timer = $"../../timer_attack"

func enter_state():
	super()
	#print("Attack Machine > Attack State")
	timer_attack.start()

func process_frame(_delta: float):
	if not movement_comp.is_within_attack_range():
		state_transition.emit(self, "attack_pursuit")
		return
	
	movement_comp.attack()
