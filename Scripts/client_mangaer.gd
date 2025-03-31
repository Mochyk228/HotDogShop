extends Node

signal next
var childrens: Array[Node]  # Array to hold duplicated nodes
var i: int = 0

func _ready() -> void:
	# Duplicate the children before freeing them
	for child in get_children():
		var duplicated_node = child.duplicate()  # Create a duplicate
		childrens.append(duplicated_node)        # Store the duplicate
		child.queue_free()                       # Free the original
	
	# Connect the signal and call next_client
	next.connect(next_client)
	await get_tree().create_timer(3.2).timeout
	next_client()

func next_client():
	if i < childrens.size():
		var next_c = childrens[i].duplicate()  # Duplicate the stored node
		next_c.hide()  # Completely hide it before adding
		add_child(next_c)  # Now add it to the scene
		await get_tree().create_timer(0.1).timeout
		next_c.show()  # Now make it visible
		i += 1
	else:
		$AudioStreamPlayer.play()
		await get_tree().create_timer(5).timeout
		$AudioStreamPlayer2.play()
