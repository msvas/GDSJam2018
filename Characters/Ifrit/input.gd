extends Node

export(NodePath) var _ifrit = @".."
onready var ifrit = get_node(_ifrit)

func _process(delta):
	movement()

func movement():
	var direction = Vector2()
	
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	if direction != Vector2():
		ifrit.get_action("move").execute(direction)
