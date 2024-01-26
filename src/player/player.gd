extends RigidBody2D
class_name Player

@onready var move_machine: FiniteStateMachine = $move_machine
@onready var web_machine: FiniteStateMachine = $web_machine
@onready var move_comp: Node2D = $move_comp
@onready var action_comp: Node2D = $web_comp
@onready var animation_player_body: AnimationPlayer = $animation_player_body
@onready var animation_player_head: AnimationPlayer = $animation_player_head

@export var head_turn_speed: float = 10
@export var head_turn_distance: float = 10
@export var dash_damage = 50
@export var direction: float = -1

signal spawn_web_rope(web_direction: Vector2, web_length: float)
signal swing
signal dismiss_web
signal death

func _ready():
	move_machine.init(self, move_comp, action_comp, animation_player_body)
	web_machine.init(self, move_comp, action_comp, animation_player_head)

func _process(delta: float):
	if globals.player_health <= 0 && not move_machine.is_in_state("move_death"):
		move_machine.force_change_state("move_death")
	if globals.player_health <= 0 && not web_machine.is_in_state("web_idle"):
		web_machine.force_change_state("web_idle")
	move_machine.process_frame(delta)
	web_machine.process_frame(delta)

func _unhandled_input(event: InputEvent):
	move_machine.process_input(event)
	web_machine.process_input(event)

func _physics_process(delta: float):
	move_machine.process_physics(delta)
	web_machine.process_physics(delta)

func collect_cocoon():
	globals.add_cocoon()

func take_damage(damage: int):
	globals.add_player_health(-damage)

func reset():
	globals.add_player_health(100)
	move_machine.force_change_state("move_idle")
