extends VBoxContainer

var is_mouse_cil : bool
var is_mouse_pyr : bool

@export var craft_system_cylinders: ScrollContainer
@export var craft_system_pyramides: ScrollContainer

func _on_cilnders_mouse_entered() -> void:
	is_mouse_cil = true


func _on_cilnders_mouse_exited() -> void:
	is_mouse_cil = false


func _on_pyramides_mouse_entered() -> void:
	is_mouse_pyr = true


func _on_pyramides_mouse_exited() -> void:
	is_mouse_pyr = false

func _process(delta: float) -> void:
	if is_mouse_cil:
		$Cilnders.get_theme_stylebox("panel").border_color = Color.WHITE
		if Input.is_action_just_pressed("left_mouse_click"):
			craft_system_cylinders.visible = true
			craft_system_pyramides.visible = false
	else:
		$Cilnders.get_theme_stylebox("panel").border_color = Color.BLACK
	if is_mouse_pyr:
		$Pyramides.get_theme_stylebox("panel").border_color = Color.WHITE
		if Input.is_action_just_pressed("left_mouse_click"):
			craft_system_cylinders.visible = false
			craft_system_pyramides.visible = true
	else:
		$Pyramides.get_theme_stylebox("panel").border_color = Color.BLACK
