extends "action.gd"

func _execute():
	var refuel_value = 0.5 #value each fire source replenish fuel
	
	if attributes.fuel + refuel_value > attributes.max_fuel:
		attributes.fuel = attributes.max_fuel
	else:
		attributes.fuel += refuel_value