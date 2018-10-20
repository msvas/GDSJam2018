extends KinematicBody2D

#CHILDS FROM NODE
onready var flame_area_node = get_node("flame area")
onready var sprite_node = get_node("sprite")

#OBJECT CUSTOMIZABLE VARIABLES
export var flamability = 3  #Time in seconds till object ignites
export var burnability = 10  #Time in seconds till object extinguish
export var REFRESH_RATE = 0.1 #Seconds till object apply heat over near objects
var is_burning = false

#GRAPHICAL EFFECTS VARIABLES
var max_red  = 1
var mod_color_subtraction = [0.1,0.1,0.1]
var mod_color = [1,1,1]

var burn_bodies_timer = null

func _ready():
	pass

func ignite():
	is_burning = true
	countdown_timer(burnability, "extinguish")
	burn_bodies_timer = countdown_timer(REFRESH_RATE, "heat_near_bodies", false)
	
	if has_method("ignite_reaction"):
		ignite_reaction()
	
	#ADD BURNING EFFECTS

func burn(time_rate):
	#Modulate sprite till max red
	mod_color[0] += max_red * REFRESH_RATE / flamability
	sprite_node.modulate = Color(mod_color[0],mod_color[1],mod_color[2])
	
	#Slowly heats the object
	flamability -= time_rate
	
	if flamability <= 0:
		ignite()
	elif has_method("burn_reaction"):
		burn_reaction()

func extinguish():
	visible = false
	burn_bodies_timer.stop()
	burn_bodies_timer.queue_free()

	#ADD BURNOUT EFFECTS
	queue_free()

func heat_near_bodies():
	#TODO BETTER - CHANGE MODULATE TO BLACK
	for i in range(0,2):
		mod_color[i] -= mod_color_subtraction[i]
	sprite_node.modulate = Color(mod_color[0],mod_color[1],mod_color[2])

	for body in flame_area_node.get_overlapping_bodies():
		#slowly ignites flammable objects
		if body.get("is_burning") == false:
			body.burn(REFRESH_RATE)
		
		#refuels ifrit
		if body.has_method("has_action") and body.has_action("refuel"):
			body.get_action("refuel")._execute()

#SUPPPORT METHODS

func countdown_timer(time, function, oneshot = true):
	#Instance timer
	var timer = Timer.new()
	add_child(timer)

	#Configure timer
	timer.one_shot = oneshot
	timer.set_wait_time(time)
	timer.connect("timeout",self,function)

	#Initialize timer
	timer.start()
	return timer