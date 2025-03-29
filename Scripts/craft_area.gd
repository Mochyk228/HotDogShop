extends Area3D

@export var craft_system: VBoxContainer


func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	craft_system.visible = true


func _on_body_exited(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	craft_system.visible = false
