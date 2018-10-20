extends "res://Characters/attributes.gd"

export(float) var fuel = 100 #actual fuel value
export(float) var max_fuel = 100 #max fuel
export(float) var fuel_consumption = 5 #fuel consumption per second

export(float) var shoot_fuel_cost = 10 #fuel cost for a shot
export(float) var fire_replenisher = 0.5 #quantity refueled per second per fire source
