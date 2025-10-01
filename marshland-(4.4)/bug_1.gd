extends CharacterBody3D

var speed = 8
var health = 20
var range = 5

var target_pos
var target

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if target_pos != null:
		look_at(target_pos)
		if $RayCast3D.is_colliding():
			pass
		
		if global_position != target_pos:
			global_position.move_toward(target_pos, speed * delta)

func hit():
	health -= 10
	if health <= 0:
		die()
	
#	alert_others()

func die():
	queue_free()

#func alert_others():
	#for i in get_tree().get_tree().get_nodes_in_group("bug"):
		#if global_position.distance_to(i.global_position) <= range:
			#i.alert_others()
			#if i.target 
	

func investigate():
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		target_pos = body.global_position
