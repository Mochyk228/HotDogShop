extends Control

signal craft_signal(is_craft : bool)

@export var craft_item : SubViewport
@export var arr : Array[String]
@export var arr_active : Array[SubViewport]
@export var arr_inactive : Array[SubViewport]
@onready var background: Panel = $Background
@onready var recepie_container: HBoxContainer = $Background/HBoxContainer
@onready var black: TextureRect = $"../../Black"

var slot : Array[Node]
var slot_num : int = 0
var int_location : int
var border : StyleBoxFlat

var index : int = -1
var craft_recepie : Array
var skip_numbers : Array
var is_craft_able : bool


@onready var old_item_count : int = index

var is_mouse : bool

func _ready() -> void:
	for i : TextureRect in recepie_container.get_children():
		i = i.duplicate(true)
	border = background.get_theme_stylebox("panel").duplicate(true)
	background.add_theme_stylebox_override("panel", border)
	slot = recepie_container.get_children()
	Inventory.inventory_signal.connect(inventory_craft)
	Inventory.clean_inventory_signal.connect(clean_inventory)
	craft_signal.connect(inventory_craft)
	background.mouse_entered.connect(mouse_enter)
	background.mouse_exited.connect(mouse_exited)

func mouse_enter(): 
	is_mouse = true

func mouse_exited():
	is_mouse = false

func clean_inventory():
	for i in range(slot.size()-1):
		slot[i].texture = arr_inactive[i].get_texture()
	inventory_craft(false)
		
func _process(delta: float) -> void:
	if is_mouse:
		inventory_craft(false)
		if not is_craft_able:
			return
		background.get_theme_stylebox("panel")
		border.border_color = Color.WHITE
		if Input.is_action_just_pressed("left_mouse_click"):
			craft_signal.emit(true)
			visual_effects()
	else:
		border.border_color = Color.BLACK
		

func visual_effects():
	$SFX.play()
	black.visible = true
	await $SFX.finished
	black.visible = false

func inventory_craft(is_craft : bool):
	for i in range(slot.size()-1):
		slot[i].texture = arr_inactive[i].get_texture()
	var list = Inventory.inventory.duplicate()
	craft_recepie = []
	skip_numbers = []
	old_item_count = -1
	index = -1
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
			is_craft_able = true
		else:
			is_craft_able = false
		if is_craft and craft_recepie == arr:
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
			children[Inventory.item_count].label = str(craft_item.name)
			Inventory.item_count += 1
			Inventory.clean_inventory_signal.emit()
			Inventory.serve_inv += [craft_item]
