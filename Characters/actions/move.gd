extends "action.gd"

func _execute(direction):
	if typeof(direction) != TYPE_VECTOR2:
		printerr('Argument to action "move" is not a Vector2 (direction)')
		return
	
	var speed = attributes.movement_speed
	
	character.move_and_slide(direction.normalized() * speed)
