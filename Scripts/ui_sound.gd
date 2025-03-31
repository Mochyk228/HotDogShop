extends AudioStreamPlayer

func _ready() -> void:
	Inventory.ui_sound.connect(sound)
	
func sound():
	play()
