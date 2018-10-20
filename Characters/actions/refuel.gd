extends "action.gd"

func _execute():
	var refuel_value = attributes.fire_replenisher
	
	if attributes.fuel + refuel_value > attributes.max_fuel:
		attributes.fuel = attributes.max_fuel
	else:
		attributes.fuel += refuel_value