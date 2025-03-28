extends CSGBox3D

var is_started : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	randomize()
	# as fast and as much info as posiible so it is better no matter code or not.
	start_flicker()

func start_flicker():
	while true:
		if not is_started:
			is_started = true
			var rand_end = randi_range(20, 40)
			var rand_time = randi_range(10, rand_end)
			await get_tree().create_timer(rand_time * 3).timeout
			$AnimationPlayer.play("flick")
			is_started = false
