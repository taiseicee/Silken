extends CharacterBody2D

@onready
var state_machine: Node = $state_machine
@onready
var movement_comp: Node = $movement_comp

func _ready():
	state_machine.init(self, movement_comp)

func _process(delta: float):
	state_machine.process_frame(delta)

func _unhandled_input(event: InputEvent):
	state_machine.process_input(event)

func _physics_process(delta: float):
	state_machine.process_physics(delta)
