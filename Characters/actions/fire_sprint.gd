extends "action.gd"

var timer = null

func _execute():
	#Activates fire_sprint and renew timer
	if timer != null:
		deactivate_timer(timer)
	else:
		activate_fire_sprint()
	timer = countdown_timer(0.3, "deactivate_fire_sprint")

func activate_fire_sprint():
	attributes.movement_speed = attributes.movement_speed * 3

func deactivate_fire_sprint():
	attributes.movement_speed = attributes.movement_speed / 3
	timer = null

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

func deactivate_timer(timer):
	timer.stop()
	timer.queue_free()