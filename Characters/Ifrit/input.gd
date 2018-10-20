extends Node

export(NodePath) var _ifrit = @".."
onready var ifrit = get_node(_ifrit)
onready var anim = ifrit.get_node("anim")
onready var sprite = ifrit.get_node("sprite")

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
		
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
		
		if not anim.is_playing():
			anim.play("walk")
	else:
		sprite.frame = 0

func shoot():
	if Input.is_action_just_pressed("shoot"):
		var direction = ifrit.get_global_mouse_position() - ifrit.position
		ifrit.get_action("shoot").execute(direction)
