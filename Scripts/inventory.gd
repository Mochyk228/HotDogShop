extends Node

signal inventory_signal(is_craft : bool)
signal clean_inventory_signal

var serve_item_container : HBoxContainer
var item_count : int = 0
var serve_inv : Dictionary:
	set(value):
		serve_inv = value
		inv_serv()
@export var inventory : Array:
	set(value):
		inventory = value
		inventory_signal.emit(false)

func inv_serv():
	#print(serve_inv[0].name)
	pass

# How to itorate instantly? 
#{ 0: "RedActive" }
#{ 0: "RedActive", 1: "BrownActive" }

func remove_serve_item(remove_item):
	# all children
	# get their names and check first name from reverse order 
	# this name disable
	# remove from inventory
	# decrese item count 
	var children = serve_item_container.get_children()
	if children[item_count].visible != false:
		return
		
	children[item_count].visible = false
	item_count -= 1
	serve_inv.erase(serve_inv.find_key(str(remove_item.name))) 
	var i = 0
	if i == serve_inv.keys()[i]:
		print(i)
		i += 1
	print(serve_inv)

func add_serve_item(add_item):
	var children = serve_item_container.get_children()
	if children[item_count].visible != false:
		return
		
	children[item_count].visible = true
	children[item_count].texture = add_item.get_texture()
	children[item_count].label = str(add_item.name)
	clean_inventory_signal.emit()
	serve_inv[item_count] = str(add_item.name)
	item_count += 1
	print(serve_inv)
