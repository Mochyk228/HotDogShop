extends Control

signal craft_signal(is_craft : bool)

@export var craft_item : SubViewport
@export var arr : Array[String]
@export var arr_active : Array[SubViewport]
@export var arr_inactive : Array[SubViewport]
@onready var background: Panel = $Background
@onready var recepie_container: HBoxContainer = $Background/HBoxContainer
@onready var black: TextureRect = get_node("/root/Root/CanvasLayer/SubViewportContainer/SubViewport/Root/CanvasLayer/Black")

var slot : Array[Node]
var border : StyleBoxFlat

var recepie_item_count : int
var is_craft_able : bool


var is_mouse : bool

func _ready() -> void:
	# make loop that refresh all slots and insert the craft slot
	
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
	
	slot[-1].texture = craft_item.get_texture()
	clean_inventory()

func mouse_enter():
	is_mouse = true 
	inventory_craft(false)
	if not is_craft_able:
		return
	background.get_theme_stylebox("panel")
	border.border_color = Color.WHITE

func _input(event):
	if is_mouse  and is_craft_able and event.is_action_pressed("left_mouse_click"):
		craft_signal.emit(true)
		visual_effects()

func mouse_exited():
	is_mouse = false
	border.border_color = Color.BLACK

func clean_inventory():
	for i in range(slot.size()-1):
		slot[i].texture = arr_inactive[i].get_texture()
	inventory_craft(false)

func visual_effects():
	$SFX.play()
	black.visible = true
	await $SFX.finished
	black.visible = false

func inventory_craft(is_craft : bool):
	for i in range(slot.size()-1):
		slot[i].texture = arr_inactive[i].get_texture()
	
	var list = Inventory.inventory.duplicate()
	recepie_item_count = 0 
	
	for i in range(arr.size()):
		if list.has(arr[i]): 
			slot[i].texture = arr_active[i].get_texture()
			recepie_item_count += 1
			list.erase(arr[i])
	
	visible = (recepie_item_count > 0)
	is_craft_able = (recepie_item_count == arr.size())
	if is_craft and is_craft_able:
		for x in arr: # here I did the same stuff but i didn't understand that it is work with double list
			if Inventory.inventory.has(x):
				Inventory.inventory.erase(x)
		
		for x in range(slot.size()-1):
			slot[x].texture = arr_inactive[x].get_texture()
			
		Inventory.add_serve_item(craft_item)
