extends Node3D

@export var needs : Array[SubViewport]
@onready var recepie: Sprite3D = $Recepie

func _ready() -> void:
	recepie.texture = needs[0].get_texture()


func _on_customer_service_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	if Inventory.serve_inv.is_empty():
		return
	for i in needs : # here i did the same stuff but I just didn't realise
		if Inventory.serve_inv.has(i.name):
			Inventory.remove_serve_item(i)
