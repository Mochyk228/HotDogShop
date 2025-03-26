extends CharacterBody3D

@onready var ray: RayCast3D = $Camera3D/RayCast3D

@export var rotation_add : float
@export var sound : AudioStream
var old_rot : float

var animation : AnimationPlayer
var is_rot_left : bool

var is_jump_1 : bool
var is_jump_2 : bool

var item_count : int = 0
var pitch : float = 0.5
var can_play : bool

@onready var camera: Camera3D = $Camera3D


const SPEED = 0.5
const JUMP_VELOCITY = 4.5

func ray_cast():
	var global = get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_start = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_start + camera.project_ray_normal(mouse_pos) * 1000
	var ray_query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	var ray_cast = global.intersect_ray(ray_query)
	
	if ray_cast and ray_cast.collider.is_in_group("Interactable"):
		var object = ray_cast.collider
		var children = $"../CanvasLayer/HBoxContainer".get_children()
		children[item_count].visible = true
		item_count += 1
		pitch += 0.4
		object.queue_free()
		$PickUpSFX.pitch_scale = pitch
		$PickUpSFX.play()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse_click"):
		ray_cast()
	
	if is_rot_left:
		rotation_degrees.y = clampf(rotation_add + old_rot, old_rot, old_rot + 90)
	else:
		rotation_degrees.y = clampf(rotation_add + old_rot, old_rot - 90, old_rot)
	
	
	if ray.is_colliding() and ray.get_collider().is_in_group("Fridge"):
		if ray.is_colliding() and ray.get_collider().is_in_group("Fridge") and not is_jump_1:
			animation = ray.get_collider().get_child(2)
			if not animation.is_playing():
				animation.play("open_door")
				is_jump_1 = true
	elif ray.is_colliding() and ray.get_collider().is_in_group("Door"):
		if ray.is_colliding() and ray.get_collider().is_in_group("Door") and not is_jump_2:
			animation = ray.get_collider().get_child(2)
			if not animation.is_playing():
				animation.play("open_door")
				is_jump_2 = true
	elif not ray.is_colliding() and animation and not animation.is_playing() and is_jump_1: 
		animation.play("close_door")
		is_jump_1 = false
	elif ray.is_colliding() and animation and not animation.is_playing() and is_jump_2:
		animation.play("close_door")
		is_jump_2 = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(sign(input_dir.x), 0, sign(input_dir.y)))
	if direction.length() > 1:
		if abs(direction.x) > 0:
			direction = Vector3(direction.x, 0, 0)
		else:
			direction = Vector3(0, 0, direction.z)
	
	if not $AnimationPlayer.is_playing():
		if Input.is_action_just_pressed("ui_right"):
			is_rot_left = false
			old_rot = rotation_degrees.y
			rotation_add = 0
			$AnimationPlayer.play("turn_right")
			direction = Vector3.ZERO
			ray.visible = false
			await get_tree().create_timer(0.2)
			ray.visible = true
		if Input.is_action_just_pressed("ui_left"):
			is_rot_left = true
			old_rot = rotation_degrees.y
			rotation_add = 0
			$AnimationPlayer.play("turn_left")
			direction = Vector3.ZERO
			ray.visible = false
			await get_tree().create_timer(0.2)
			ray.visible = true
	
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		


	move_and_slide()

func _process(delta):
	if $PickUpSFX.is_playing():
		$"../CanvasLayer/Black".visible = true
	else:
		$"../CanvasLayer/Black".visible = false
	
	if velocity.length() > 0.1:
		$AnimationPlayer2.play("walk")
		if not can_play:
			can_play = true
			play_sound()
			await get_tree().create_timer(0.4).timeout
			can_play = false
	else:
		$AnimationPlayer2.stop()

func play_sound():
	$FootSound.stream = sound
	$FootSound.max_db = 0 + randi_range(-7, -5)
	$FootSound.pitch_scale = 1 + randf_range(-0.5, 0.5)
	$FootSound.play()
