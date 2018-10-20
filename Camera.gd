extends Camera2D

var shake_offset = Vector2()

func screenshake(duration = 1, amount = 1):
	get_node("AudioStreamPlayer2D").play(0)
	var timer = 0.0
	
	$tween.interpolate_property(
		self, "shake_offset", Vector2(amount, amount), Vector2(), duration,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	$tween.start()
	
	while timer < duration:
		offset = Vector2(
			rand_range(-1.0, 1.0) * shake_offset.x,
			rand_range(-1.0, 1.0) * shake_offset.y
		)
		
		yield(get_tree(), "idle_frame")
		timer += get_process_delta_time()
	
	offset = Vector2()
