extends AudioStreamPlayer3D

var once: bool = true
var timer: Timer
var prev_position: Vector3 = Vector3.ZERO

func _ready() -> void:
	# Start playing the sound when the scene starts
	play()
	
	# Create a Timer node dynamically
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
	# Set a random timer duration and start it
	reset_timer()

func _process(delta: float) -> void:
	if once:
		position.z = -2
		once = false
	
	# Update position (Doppler effect will work automatically)
	prev_position = position
	position.z += 2 * delta  # Move along Z axis

func reset_timer() -> void:
	# Set a random wait time between min and max values (5 to 20 seconds)
	timer.wait_time = randf_range(5.0, 20.0)
	timer.start()

func _on_timer_timeout() -> void:
	play()
	reset_timer()
