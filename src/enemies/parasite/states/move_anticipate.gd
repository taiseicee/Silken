extends State

@onready var timer: Timer = $"../../timer"
var will_release: bool = false

func enter_state():
	super()
	print("Move Machine > Anticipate State")
	timer.start()

func process_physics(_delta: float):
	if not will_release:
		return
	timer.start()
	will_release = false
	if movement_comp.should_change_direction():
		print("- changing direction")
		movement_comp.change_direction()
	state_transition.emit(self, "move_release")

func _on_timer_timeout():
	will_release = true
