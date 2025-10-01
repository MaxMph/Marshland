extends CharacterBody3D

@export var speed: float = 110.0
@export var drag: float = 1.0
@export var drop: float = 1.0

var dmg: float

@onready var ray = RayCast3D.new()

var spawn_transform
#var spawn_pos
#var spawn_rot
var last_pos

var sender = null

func _ready() -> void:
	add_sibling(ray)
	
	global_transform = spawn_transform
	scale = Vector3.ONE
	
	velocity = transform.basis * Vector3(0,0,-speed)
	last_pos = position
	ray.global_position = global_position
	await get_tree().create_timer(0.1).timeout
	#$MeshInstance3D3.visible = true
	print(scale)
	
	


func _process(delta: float) -> void:
	ray.target_position = global_position - ray.global_position
	ray.position = last_pos
	last_pos = position
	ray.force_raycast_update()
	
	velocity.y -= drop * delta
	
	if ray.is_colliding():
		if ray.get_collider().has_method("hit"):
			ray.get_collider().hit(dmg)
		ray.queue_free()
		#ray.get_collision_normal()
		print("ertgyuhij")
		queue_free()
	
	move_and_slide()
