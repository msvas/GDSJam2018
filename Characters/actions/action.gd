extends Node

export(bool) var enabled = true
export(NodePath) var _character = @"../.."
export(NodePath) var _attributes = @"../../attributes"

onready var character = get_node(_character)
onready var attributes = get_node(_attributes)

func can_execute():
	return enabled

func execute(args = null):
	if can_execute():
		_execute(args)

func _execute(args = null):
	pass
