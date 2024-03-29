extends CharacterBody2D

@onready var move_machine: FiniteStateMachine = $move_machine
@onready var attack_machine: FiniteStateMachine = $attack_machine
@onready var move_comp: Node = $move_comp
@onready var attack_comp: Node = $attack_comp
@onready var health_bar: ProgressBar = $health_bar

@export var health_max: int = 100
@export var base_speed: int = 350
@export var pusue_speed_multiplier: float = 1.2
@export var base_attack_damage: int = 10
@export var attack_range: float = 75
@export var direction: int = -1

var player
var is_dead = false

signal dead(position)

func _ready():
	health_bar.value = health_max
	health_bar.max_value = health_max
	move_machine.init(self, move_comp, attack_comp, null)
	attack_machine.init(self, move_comp, attack_comp, null)

func _process(delta: float):
	if is_dead: return
	move_machine.process_frame(delta)
	attack_machine.process_frame(delta)

func _unhandled_input(event: InputEvent):
	if is_dead: return
	move_machine.process_input(event)
	attack_machine.process_input(event)

func _physics_process(delta: float):
	if is_dead: return
	move_machine.process_physics(delta)
	attack_machine.process_physics(delta)

func take_damage(damage_value: int):
	health_bar.value -= damage_value
	if health_bar.value > 0: return
	dead.emit(global_position)
	is_dead = true

func _on_vision_body_entered(body):
	if body is Player:
		player = body

func _on_vision_body_exited(body):
	if body is Player:
		player = null
