extends Area2D

export var max_reach = 200
export var direction = Vector2(1, 0)
export var speed = 500

var traveled = 0
func _process(delta):
	var movement = direction * speed * delta
	
	position += movement
	
	traveled += movement.length()
	if traveled >= max_reach and not $anim.current_animation == "fade":
		$anim.play("fade")


func _on_Fireball_body_entered(body):
	if body.has_method("ignite"):
		#activate flammable object if hasnt yet
		if body.get("is_burning") == false:
			body.ignite()
		
		#destroy fireball
		set_process(false)
		$anim.play("fade") 
