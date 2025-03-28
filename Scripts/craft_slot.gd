extends Control

@export var craft_item : SubViewport
@export var arr : Array
@export var dir : Dictionary[int, Dictionary]

var slot : Array[Node]
var slot_num : int = 0

var item_count : int = 0


func _ready() -> void:
	slot = $Background/HBoxContainer.get_children()
	Inventory.inventory_signal.connect(inventory_craft)
	
func _process(delta: float) -> void:
	print(Inventory.inventory)
	
func get_dictornary(type : String, slot_n : int):
	if type == "active":
		if dir.size() - 1 >= slot_n:
			return dir.values()[slot_n].get_texture()
		else:
			return dir.values()[slot_n - 1].get_texture()
	elif type == "inactive":
		if dir.size() - 1 >= slot_n:
			return dir.keys()[slot_n].get_texture()
		else:
			return dir.keys()[slot_n -2].get_texture()

func inventory_craft():
	var list = Inventory.inventory
	for i in list:
		if slot_num == arr.size()-1:
			print(arr.size()-1)
			var children = $"../../HBoxContainer".get_children()
			if children[item_count].visible != false:
				return
			children[item_count].visible = true
			children[item_count].texture = craft_item.get_texture()
			item_count += 1
			for x in arr: 
				Inventory.inventory.erase(x)
			while slot_num > 0:
				slot[slot_num -1].texture = get_dictornary("inactive", slot_num)
				slot_num -= 1
		elif i == arr[slot_num]:
			slot[slot_num].texture = get_dictornary("active", slot_num)
			slot_num += 1
