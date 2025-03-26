extends CSGBox3D

var is_started : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	while true:
		if not is_started:
			is_started = true
			var rand_time = randi_range(10, 300)
			await get_tree().create_timer(rand_time).timeout
			print(1)
			is_started = false
