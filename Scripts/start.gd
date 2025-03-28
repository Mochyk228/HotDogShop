extends Camera3D

@export var is_translate : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_translate:
		$"../CanvasLayer/Black".visible = true
		$"../CharacterBody3D".visible = true
		await get_tree().create_timer(2).timeout
		$"../CanvasLayer/Black".visible = false
		queue_free()
	else:
		$"../CharacterBody3D".visible = false
