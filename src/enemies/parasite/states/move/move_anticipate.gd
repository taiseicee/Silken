extends State

@onready var timer_release: Timer = $"../../timer_release"
var will_release: bool = false

func enter_state():
	super()
	print("Move Machine > Anticipate State")
	timer_release.start()

func process_physics(delta: float):
	super(delta)
	if movement_comp.is_within_attack_range() && movement_comp.should_pursue():
		state_transition.emit(self, "move_idle")
		return
	
	if not will_release:
		return
	timer_release.start()
	will_release = false
	state_transition.emit(self, "move_release")

func _on_timer_timeout():
	will_release = true
