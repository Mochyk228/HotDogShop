extends Area3D


func _on_body_entered(body: Node3D) -> void:
	$"../CanvasLayer/CraftSystem".visible = true


func _on_body_exited(body: Node3D) -> void:
	$"../CanvasLayer/CraftSystem".visible = false
