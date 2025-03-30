extends Node3D

@export var needs : Array[SubViewport]
@onready var recepie: Sprite3D = $Recepie

func _ready() -> void:
	recepie.texture = needs[0].get_texture()


func _on_customer_service_body_exited(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	
