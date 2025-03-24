extends CharacterBody3D

@onready var ray: RayCast3D = $RayCast3D

var animation : AnimationPlayer
var is_open : bool


const SPEED = 0.5
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	if ray.is_colliding() and ray.get_collider().is_in_group("Fridge") and not is_open:
		animation = ray.get_collider().get_child(2)
		if not animation.is_playing():
			animation.play("open_door")
			is_open = true
	elif not ray.is_colliding() and animation and not animation.is_playing() and is_open:
		animation.play("close_door")
		is_open = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
