extends CharacterBody2D

@onready var move_machine: FiniteStateMachine = $move_machine
@onready var movement_comp: Node = $movement_comp

func _ready():
	move_machine.init(self, movement_comp)

func _process(delta: float):
	move_machine.process_frame(delta)

func _unhandled_input(event: InputEvent):
	move_machine.process_input(event)

func _physics_process(delta: float):
	move_machine.process_physics(delta)
