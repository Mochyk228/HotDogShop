extends Control

@export var craft_item : SubViewport
@export var arr : Array[String]
@export var arr_active : Array[SubViewport]
@export var arr_inactive : Array[SubViewport]
@export var recepie_container : HBoxContainer

var slot : Array[Node]
var slot_num : int = 0
var int_location : int


var index : int = -1
var craft_recepie : Array
var skip_numbers : Array

@onready var old_item_count : int = index

var is_mouse : bool

func _ready() -> void:
	slot = recepie_container.get_children()
	Inventory.inventory_signal.connect(inventory_craft)
	Inventory.clean_inventory_signal.connect(clean_inventory)


func clean_inventory():
	for i in range(slot.size()-1):
		slot[i].texture = arr_inactive[i].get_texture()
		
func _process(delta: float) -> void:
	if is_mouse:
		print(name)
		if Input.is_action_just_pressed("left_mouse_click"):
			print(1)
	else:
		print("turn off outline")

func inventory_craft():
	#slot_num = 0
	#var slot_pass : Array = []
	#for i in list:
		#print(slot_num)
		#if slot_pass.size() == arr.size():
			#print(arr.size()-1)
			#var children = $"../../HBoxContainer".get_children()
			#if children[item_count].visible != false:
				#return
			#children[item_count].visible = true
			#children[item_count].texture = craft_item.get_texture()
			#item_count += 1
			#for x in arr: 
				#Inventory.inventory.erase(x)
			#while slot_num > 0:
				#slot[slot_num].texture = arr_inactive[slot_num].get_texture() # -1 cause first obj is craft materail
				#slot_num -= 1
		#elif i == arr[slot_num]:
			#if not slot_pass.has(slot_num):
				#slot_pass.append(slot_num)
			#slot[slot_num].texture = arr_active[slot_num].get_texture()
			#slot_num += 1
		#else:
			#slot_num += 1
	
	# idealy i should safe or ingnore alreay getted file so mb save in the list?
	#inc = 0
	#for x in arr: # check all inpector list
		##print("Inventory: ", Inventory.inventory)
		##print(Inventory.inventory)
		#
		#for y in list: # collect point for each right combination
			#if y == x:
				#slot[inc].texture = arr_active[inc].get_texture()
				#var index = list.find(y)
				#list.remove_at(index)
				#inc += 1
		#print("inc: ", inc)
		#if inc == arr.size():
			#for c in arr:
				#for y in Inventory.inventory:
					#if y == c:
						#Inventory.inventory.erase(y)
			#print("pass")
			#break
	# the problem is that one turn
	# could happened that not this stuff will cruft so it should be erased so it should work with live inventory
		# Step 1: Reset all slots to inactive textures
	for i in range(slot.size()-1):
		slot[i].texture = arr_inactive[i].get_texture()
	var list = Inventory.inventory.duplicate()
	craft_recepie = []
	skip_numbers = []
	old_item_count = -1
	index = -1
	#reset skip number
	var arr_copy = arr.duplicate()
	for x in arr:
		for y in list:
			if x == y:
				craft_recepie.append(y)
				index = craft_recepie.size()-1
				if old_item_count != index:
					for c in range(arr.size()):
						if arr[c] == y:
							if skip_numbers.has(c):
								continue
							slot[c].texture = arr_active[c].get_texture()
							skip_numbers.append(c)
							break
				old_item_count = index
				list.erase(y)
				break
		if craft_recepie == arr:
			for y in craft_recepie:
				if Inventory.inventory.has(y):
					Inventory.inventory.erase(y)
			for i in range(slot.size()-1):
				slot[i].texture = arr_inactive[i].get_texture()
			var children = $"../../HBoxContainer".get_children()
			if children[Inventory.item_count].visible != false:
				return
			children[Inventory.item_count].visible = true
			children[Inventory.item_count].texture = craft_item.get_texture()
			Inventory.item_count += 1
			Inventory.clean_inventory_signal.emit()


func _on_background_mouse_entered() -> void:
	is_mouse = true


func _on_background_mouse_exited() -> void:
	is_mouse = false
