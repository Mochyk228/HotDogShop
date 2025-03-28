extends Node

signal inventory_signal

@export var inventory : Array:
	set(value):
		inventory = value
		inventory_signal.emit()
