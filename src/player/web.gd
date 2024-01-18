extends StaticBody2D
class_name Web

@onready var web_spring: DampedSpringJoint2D = $web_spring
@onready var web_line: Line2D = $web_line
var body

func _process(delta):
	web_line.points = []
	if body:
		web_line.add_point(Vector2.ZERO)
		web_line.add_point(body.global_position - global_position)

func connect_to_body(body: PhysicsBody2D, pivot_point: Vector2, web_length: float):
	self.body = body
	global_position = pivot_point
	web_spring.rotation = pivot_point.angle_to_point(body.position) - PI/2
	web_spring.length = web_length
	web_spring.rest_length = 1 
	web_spring.node_b = body.get_path()

func disconnect_from_body():
	web_spring.node_b = get_path()
	body = null
