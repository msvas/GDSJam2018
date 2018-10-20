extends "action.gd"

func _execute():
	var refuel_value = attributes.fire_replenisher
	
	if attributes.fuel + refuel_value > attributes.max_fuel:
		attributes.fuel = attributes.max_fuel
	else:
		attributes.fuel += refuel_value
	
	#deactivate line below to remove fire_sprint
	get_node("../fire_sprint")._execute()