extends RigidBody2D
class_name Player

@onready var move_machine: FiniteStateMachine = $move_machine
@onready var web_machine: FiniteStateMachine = $web_machine
@onready var movement_comp: Node = $movement_comp
@onready var key_manager: Node = $movement_comp/key_manager
@onready var animation_player_body: AnimationPlayer = $animation_player_body
@onready var animation_player_head: AnimationPlayer = $animation_player_head

signal spawn_web
signal swinging
signal dismiss_web
signal spawn_web_attack(direction: Vector2)

func _ready():
	move_machine.init(self, movement_comp, null, animation_player_body)
	web_machine.init(self, movement_comp, null, animation_player_head)

func _process(delta: float):
	move_machine.process_frame(delta)
	web_machine.process_frame(delta)

func _unhandled_input(event: InputEvent):
	move_machine.process_input(event)
	web_machine.process_input(event)

func _physics_process(delta: float):
	move_machine.process_physics(delta)
	web_machine.process_physics(delta)

func collect_cocoon():
	globals.cocoon_num += 1
	print("- Coccons Collected: %d" % [globals.cocoon_num])
