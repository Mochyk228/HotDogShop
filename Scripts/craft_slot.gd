extends Control

@export var arr : Array
@export var dir : Dictionary[SubViewport, SubViewport]

var slot : Array[Node]
var slot_num : int = 0
# how to acsess slots by namber from 0 - insert them inside of array
# hot to change slots to be active? - should be inditifier of what type of slot it is and to have active or not active state

# HOW TO FIX that when i make sub view port a scene constantly path is brakes
func _ready() -> void:
	slot = $Background/HBoxContainer.get_children()
	#$Background/HBoxContainer/PreviewTexture.texture = dir.values()[0].get_texture()
	Inventory.inventory_signal.connect(inventory_craft)
	
func get_dictornary(type : String, slot_n : int):
	if type == "active":
		print(1)
		if dir.size() - 1 >= slot_n:
			return dir.values()[slot_n].get_texture()
		else:
			print(2)
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
			print("Here your item")
			while slot_num > 0:
				slot[slot_num -1].texture = get_dictornary("inactive", slot_num)
				slot_num -= 1
		elif i == arr[slot_num]:
			# make to insert inside of dictionary active state and inactive state - make a dictionary that connect by numbers
			slot[slot_num].texture = get_dictornary("active", slot_num)
			slot_num += 1
		else:
			slot_num = 0
			return
	# hot to check in one if statments if there is two of the same name?
	# have it's own list and just discard by one item and if all is fine check does list have all by one item.
	# so for item in dictionary should discard and activate by one item, so 3 items so 3 dictonary and each time it comtimues or brakes
# update all slots by cheking does it is enough
# update slots so one can story one item and second is need two of the same item
# connect inventory to slots
# make flexibale slot checking so it only continue if all privouse is yes so it should brake
