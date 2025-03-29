extends Node

signal inventory_signal(is_craft : bool)
signal clean_inventory_signal

var item_count : int = 0
@export var inventory : Array:
	set(value):
		inventory = value
		inventory_signal.emit(false)
