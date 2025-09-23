extends Node3D
@export var spread = 0.1



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
		hitpoint = %RayCast3D.target_position
	
	#show bullet line
	#var shot_trail = 
	%"bullet trail".scale.y = (%RayCast3D.global_position - hitpoint).length()
	%"bullet trail".position.z = %"bullet trail".scale.y * -0.5
	%"bullet trail".show()
	await  get_tree().create_timer(0.01).timeout
	%"bullet trail".hide()
	
	%RayCast3D.rotation = Vector3.ZERO
