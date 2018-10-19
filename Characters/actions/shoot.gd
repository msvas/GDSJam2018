extends "action.gd"

export(PackedScene) var projectile_scene

func _execute(direction):
	if typeof(direction) != TYPE_VECTOR2:
		printerr('Argument to action "shoot" is not a Vector2 (direction)')
		return
	
	var projectile = projectile_scene.instance()
	projectile.position = character.position
	projectile.direction = direction.normalized()
	add_child(projectile)
