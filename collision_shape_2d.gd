extends CollisionShape2D

@export var vec : Vector2

func _ready():
	apply_scale(vec)
	#scale = Vector2(1,1)
	print(2)
