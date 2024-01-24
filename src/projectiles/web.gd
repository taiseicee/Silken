extends StaticBody2D
class_name Web

@onready var web_spring: DampedSpringJoint2D = $web_spring
@onready var web_line: Line2D = $web_line
var from_body

func _process(_delta):
	web_line.points = []
	if from_body:
		web_line.add_point(Vector2.ZERO)
		web_line.add_point(from_body.global_position - global_position)

func shoot_web(body: PhysicsBody2D, pivot_point: Vector2):
	from_body = body
	global_position = pivot_point

func connect_to_body(body: PhysicsBody2D):
	web_spring.length = (body.global_position - global_position).length()
	web_spring.rotation = global_position.angle_to_point(from_body.global_position) - PI/2
	web_spring.rest_length = 1 
	web_spring.node_b = from_body.get_path()

func disconnect_from_body():
	web_spring.node_b = get_path()
	from_body = null
