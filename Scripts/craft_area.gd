extends Area3D

@export var craft_system: VBoxContainer
@export var craft_system2: VBoxContainer
@export var cilnders: Panel
@export var pyramides: Panel


func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	if cilnders and pyramides:
		cilnders.visible = true
		pyramides.visible = true
	craft_system2.visible = true
	craft_system.visible = true


func _on_body_exited(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	if cilnders and pyramides:
		cilnders.visible = false
		pyramides.visible = false
	craft_system2.visible = false
	craft_system.visible = false
