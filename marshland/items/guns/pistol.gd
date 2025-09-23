extends Node3D
@export var spread = 0.1

#@onready var trail = preload("res://items/guns/bullet_trail.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attack():
	%RayCast3D.rotation = Vector3(randf_range(0, spread), randf_range(0, spread), randf_range(0, spread))
	var hitpoint = Vector3.ZERO
	if %RayCast3D.is_colliding():
		if %RayCast3D.get_collider().has_method("hit"):
			%RayCast3D.get_collider().hit()
		hitpoint = %RayCast3D.get_collision_point()
	
	if hitpoint == Vector3.ZERO:
		#hitpoint = %RayCast3D.target_position
		hitpoint = %RayCast3D.global_position + %RayCast3D.global_transform.basis.z * %RayCast3D.target_position.z
	
	#show bullet line
	#var shot_trail = 
	%"bullet trail".scale.y = (%RayCast3D.global_position - hitpoint).length()
	%"bullet trail".position.z = %"bullet trail".scale.y * -0.5
	%"bullet trail".show()
	await  get_tree().create_timer(0.01).timeout
	%"bullet trail".hide()
	
	
	#new_trail.global_rotation = %RayCast3D.global_rotation
	#new_trail.scale.y = (%RayCast3D.global_position - hitpoint).length()
	#new_trail.global_position = $%RayCast3D.global_position
	#new_trail.position.z += %"bullet trail".scale.y * -0.5
	
	#new_trail.global_rotation = %RayCast3D.global_rotation
	#new_trail.scale.z = (%RayCast3D.global_position - hitpoint).length()
	#new_trail.global_position = (%RayCast3D.global_position + hitpoint) * 0.5
	#new_trail.global_rotation = %RayCast3D.global_rotation
	#new_trail.global_position = %RayCast3D.global_position + (%RayCast3D.global_position - hitpoint)
	#
	
	#new_trail.global_position = (%RayCast3D.global_position + hitpoint) * 0.5
	#new_trail.look_at(%RayCast3D.global_position - hitpoint)
	#new_trail.look_at(%RayCast3D.global_position, hitpoint)
	
	# Rotate the trail to face the direction
	#new_trail.look_at(hitpoint, Vector3.UP)
	
	# Scale the trail along the Z axis (assuming the mesh points forward along Z)
	
	
	
	#BELOW THIS ACTUALY WORKS
	
	#var new_trail = trail.instantiate()
	#new_trail.scale = Vector3(1, 1, (%RayCast3D.global_position - hitpoint).length())
	#
	#get_tree().root.add_child(new_trail)
	#
	#new_trail.global_position = (%RayCast3D.global_position + hitpoint) * 0.5
	#new_trail.look_at(hitpoint)
	
	
	%RayCast3D.rotation = Vector3.ZERO
