extends Node

signal inventory_signal(is_craft : bool)
signal clean_inventory_signal

var item_count : int = 0
var serve_inv : Array:
	set(value):
		serve_inv = value
		inv_serv()
@export var inventory : Array:
	set(value):
		inventory = value
		inventory_signal.emit(false)

func inv_serv():
	print(serve_inv[0].name)
