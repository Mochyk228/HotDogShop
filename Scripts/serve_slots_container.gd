extends HBoxContainer

func _ready() -> void:
	Inventory.serve_item_container = self
