extends AudioStreamPlayer

@export var min_wait_time: float = 30.0  # Minimum wait time in seconds (30 seconds)
@export var max_wait_time: float = 600.0  # Maximum wait time in seconds (600 seconds)

func _ready() -> void:
	# Start the random playback loop
	start_playback()

func start_playback() -> void:
	while true:
		# Wait for a random duration between 30 and 600 seconds
		var wait_time = randf_range(min_wait_time, max_wait_time)
		await get_tree().create_timer(wait_time).timeout
		
		# Play the sound
		play()
