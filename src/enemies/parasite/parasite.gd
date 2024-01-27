extends CharacterBody2D
class_name Parasite

@onready var move_machine: FiniteStateMachine = $move_machine
@onready var attack_machine: FiniteStateMachine = $attack_machine
@onready var move_comp: Node = $move_comp
@onready var health_bar: ProgressBar = $health_bar

@export var health_max: int = 100

func _ready():
	health_bar.value = health_max
	health_bar.max_value = health_max
	move_comp.init()
	attack_machine.init(self, move_comp, null, $AnimationPlayer)
	move_machine.init(self, move_comp, null, $AnimationPlayer)

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
	if health_bar.value <= 0:
		#TODO: Force State
		queue_free()
