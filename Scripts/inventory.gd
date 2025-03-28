extends Node

signal inventory_signal
signal clean_inventory_signal

var item_count : int = 0
@export var inventory : Array:
	set(value):
		inventory = value
		call_deferred("emit_signal", "inventory_signal")
