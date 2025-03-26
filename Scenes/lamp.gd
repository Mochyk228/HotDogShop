extends CSGBox3D

var is_started : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	while true:
		if not is_started and not $AnimationPlayer.is_playing():
			is_started = true
			var rand_time = randi_range(40, 120)
			await get_tree().create_timer(rand_time).timeout
			$AnimationPlayer.play("flick")
			is_started = false
