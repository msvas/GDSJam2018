extends Area2D

export var max_reach = 200
export var direction = Vector2(1, 0)
export var speed = 500

var traveled = 0
func _process(delta):
	var movement = direction * speed * delta
	
	position += movement
	
	traveled += movement.length()
	if traveled >= max_reach and not $anim.is_playing():
		$anim.play("fade")
