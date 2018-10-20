extends KinematicBody2D

onready var actions = $actions
onready var attributes = $attributes

func has_action(action):
	return actions.has_node(action)

func get_action(action):
	if self.has_action(action):
		return actions.get_node(action)

func has_attribute(attribute):
	return attributes.get(attribute) != null

func get_attribute(attribute):
	return attributes.get(attribute)

func set_attribute(attribute, value):
	attributes.set(attribute, value)
