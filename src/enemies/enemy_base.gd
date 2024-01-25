extends CharacterBody2D

@onready var move_machine: FiniteStateMachine = $move_machine
@onready var attack_machine: FiniteStateMachine = $attack_machine
@onready var move_comp: Node = $move_comp
@onready var attack_comp: Node = $attack_comp
@onready var health_bar: ProgressBar = $health_bar

@export var health_max: int = 100
@export var base_speed: int = 500
@export var pusue_speed_multiplier: int = 1.2
@export var base_attack_damage: int = 10
@export var attack_range: float = 125

var player

func _ready():
	health_bar.value = health_max
	health_bar.max_value = health_max
	attack_machine.init(self, move_comp, attack_comp)
	attack_machine.init(self, move_comp, attack_comp)

func _process(delta: float):
	move_machine.process_frame(delta)
	attack_machine.process_frame(delta)

func _unhandled_input(event: InputEvent):
	move_machine.process_input(event)
	attack_machine.process_input(event)

func _physics_process(delta: float):
	move_machine.process_physics(delta)
	attack_machine.process_physics(delta)

func take_damage(damage_value: int):
	health_bar.value -= damage_value
	if health_bar.value > 0: return
	move_machine.force_change_state("move_death")
	attack_machine.force_change_state("attack_idle")

func _on_vision_body_entered(body):
	if body is Player:
		player = body

func _on_vision_body_exited(body):
	if body is Player:
		player = null
