extends Node

signal inventory_signal(is_craft : bool)
signal clean_inventory_signal

@onready var serve_item_container: HBoxContainer = get_node("/root/Root/CanvasLayer/ServeSlotsContainer")
@onready var brown_active: SubViewport = get_node("/root/Root/BrownActive")
@onready var red_active: SubViewport = get_node("/root/Root/RedActive")


var item_count : int = 0
var serve_inv : Dictionary

@export var inventory : Array:
	set(value):
		inventory = value
		inventory_signal.emit(false)

#func _ready() -> void:
	#add_serve_item(red_active)
	#add_serve_item(brown_active)
	#add_serve_item(red_active)
	#remove_serve_item(red_active)


func remove_serve_item(remove_item):
	var children = serve_item_container.get_children()
	for i in range(children.size() -1,-1,-1):
		if children[i].visible and children[i].label == remove_item.name:
			children[i].visible = false
			serve_inv.erase(i)
			item_count -= 1
			break

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
