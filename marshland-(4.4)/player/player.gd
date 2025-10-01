extends CharacterBody3D

var jump_vel = 6
var speed = 8
var acc = 20
var fric = 20

var sense = 0.001
@export var head: Node3D
@export var cam: Camera3D

var cur_recoil_rot: Vector3
var recoil_target: Vector3

var spawn_pos

func _ready() -> void:
	pass
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	spawn_pos = global_position

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sense)
		cam.rotate_x(-event.relative.y * sense)
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-75), deg_to_rad(75))
		

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel
		print("jump")
		
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * speed, acc * delta)
		velocity.z = move_toward(velocity.z, direction.z * speed, acc * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, fric * delta)
		velocity.z = move_toward(velocity.z, 0, fric * delta)

	if Input.is_action_just_pressed("attack"):
		attack()

	if global_position.y <= -0.858:
		die()

	move_and_slide()
	
	recoil_target = lerp(recoil_target, Vector3.ZERO, 9 * delta)
	cur_recoil_rot = lerp(cur_recoil_rot, recoil_target, 12 * delta)
	%recoil.rotation = cur_recoil_rot

func attack():
	pass
	for i in $head/recoil/Camera3D/equiped.get_children():
		if i.visible:
			if i.has_method("attack"):
				i.attack()
	
	#var newspell = spell.instantiate()
	#newspell.rotation = $head/Camera3D.global_rotation
	##newspell.global_rotation = $head/Camera3D/wand.global_rotation
	#newspell.global_position = $head/Camera3D/wand.global_position
	#get_parent().add_child(newspell)
	#newspell.global_rotation = $head/Camera3D.global_rotation

func recoil(target):
	recoil_target = target

func die():
	$AnimationPlayer.play("death")
	global_position = spawn_pos
	
