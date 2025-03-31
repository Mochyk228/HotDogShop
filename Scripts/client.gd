extends Node3D

@export var needs : Array[SubViewport]
@onready var recepie: Node3D = $Recepies

func _ready() -> void:
	$AnimationPlayer.play("walk_1")
	$humanoid2/AnimationPlayer.play("Walking")
	$humanoid2/AnimationPlayer.speed_scale = 1.5
	recepie.visible = false
	await $humanoid2/AnimationPlayer.animation_finished
	recepie.visible = true
	$humanoid2/AnimationPlayer.speed_scale = 1
	$humanoid2/AnimationPlayer.play("Talking")
	
	var children = recepie.get_children()
	for i in range(children.size()-1, -1, -1):
		children[i].texture = needs[i].get_texture()


func finish():
	recepie.visible = false
	await get_tree().create_timer(0.2).timeout
	$Cloud.visible = false
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("walk_2")
	$humanoid2/AnimationPlayer.play("Walking")
	await $humanoid2/AnimationPlayer.animation_finished
	get_parent().next.emit()
	queue_free()

func _on_customer_service_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	if Inventory.serve_inv.is_empty():
		return
	var list = Inventory.serve_inv.duplicate()
	var count = 0
	for i in needs:
		if list.values().has(i.name):
			count += 1
			var key = list.find_key(i.name)
			list.erase(key)
	if count == needs.size():
		for i in needs:
			Inventory.remove_serve_item(i)
		finish()
