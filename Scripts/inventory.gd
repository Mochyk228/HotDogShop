extends Node

signal inventory_signal

@export var inventory : Array:
	set(value):
		inventory = value
		call_deferred("emit_signal", "inventory_signal")
