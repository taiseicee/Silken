extends RigidBody2D

@onready var move_machine: FiniteStateMachine = $move_machine
@onready var web_machine: FiniteStateMachine = $web_machine
@onready var movement_comp: Node = $movement_comp
@onready var key_manager: Node = $movement_comp/key_manager

var can_swing: bool = false

signal spawn_web
signal dismiss_web

func _ready():
	movement_comp.init(self, key_manager)
	move_machine.init(self, movement_comp)
	web_machine.init(self, movement_comp)

func _process(delta: float):
	move_machine.process_frame(delta)
	web_machine.process_frame(delta)

func _unhandled_input(event: InputEvent):
	move_machine.process_input(event)
	web_machine.process_input(event)

func _physics_process(delta: float):
	move_machine.process_physics(delta)
	web_machine.process_physics(delta)
