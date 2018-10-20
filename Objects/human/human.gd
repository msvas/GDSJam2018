extends "res://Objects/base_object/base_flammable.gd"

signal dead

export(NodePath) var _navigation
export var speed = 150
export var threshold = 5

var navigation
var path = PoolVector2Array()

var timer = null
var skeleton = null

func _ready():
	burnability = 2
	
	randomize()
	if _navigation and has_node(_navigation):
		navigation = get_node(_navigation)
		update_path()
		$timer.connect("timeout", self, "update_path")

func _process(delta):
	random_walk()

func update_path():
	var point = Vector2()
	
	point.x = rand_range($range_begin.position.x, $range_end.position.x)
	point.y = rand_range($range_begin.position.y, $range_end.position.y)
	
	path = navigation.get_simple_path(position, position + point)

func random_walk():
	if path.size() > 0:
		var distance = (path[0] - position).length()
		var direction = (path[0] - position).normalized()
		
		if direction.x < 0:
			$Sprite.flip_h = true
		elif direction.x > 0:
			$Sprite.flip_h = false
		
		move_and_slide(direction * speed)
		if $Sprite/anim.current_animation == "idle":
			$Sprite/anim.play("walk")
		
		if distance <= threshold:
			path.remove(0)
	elif $timer.is_stopped() and $Sprite/anim.current_animation != "burn":
		$timer.wait_time = rand_range(1, 5)
		$Sprite/anim.play("idle")
		$timer.start()
	elif navigation and $Sprite/anim.current_animation == "burn":
		update_path()

func ignite_reaction():
	$"Sprite/anim".play("burn")
	speed *= 2

func extinguish_reaction():
	emit_signal("dead")
	
	skeleton = load("res://Objects/human/skeleton.tscn").instance()
	skeleton.position = position
	skeleton.position.y -= 20
	get_node("..").add_child(skeleton)
	
	return false
