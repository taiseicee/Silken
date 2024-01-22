extends CharacterBody2D
class_name Parasite

@onready var move_machine: FiniteStateMachine = $move_machine
@onready var attack_machine: FiniteStateMachine = $attack_machine
@onready var movement_comp: Node = $movement_comp

@export var health: int = 100

func _ready():
	movement_comp.init()
	attack_machine.init(self, movement_comp)
	move_machine.init(self, movement_comp)

func _process(delta: float):
	move_machine.process_frame(delta)
	attack_machine.process_frame(delta)

func _unhandled_input(event: InputEvent):
	move_machine.process_input(event)
	attack_machine.process_input(event)

func _physics_process(delta: float):
	move_machine.process_physics(delta)
	attack_machine.process_physics(delta)

func damage(damage_value: int):
	health -= damage_value
	print("Parasite Health: %d" % [health])
