extends Node

export(NodePath) var _ifrit = @".."
onready var ifrit = get_node(_ifrit)

func _process(delta):
	movement()
	shoot()

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

func shoot():
	if Input.is_action_just_pressed("shoot"):
		var direction = get_viewport().get_mouse_position() - ifrit.position
		ifrit.get_action("shoot").execute(direction)
