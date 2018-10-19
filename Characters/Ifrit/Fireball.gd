extends KinematicBody2D

export var direction = Vector2(1, 0)
export var speed = 500

func _process(delta):
	var movement = direction * speed * delta
	
	if not test_move(get_transform(), movement):
		move_and_collide(movement)
