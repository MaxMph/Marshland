extends CharacterBody3D

var player
var speed = 4
var decel = 8
var health = 40
#var damage = 10

var tracking = false

var starting_pos = Vector3.ZERO

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	starting_pos = global_position


func _physics_process(delta: float) -> void:
	tracking = false
	velocity = Vector3.ZERO
	#velocity.move_toward(Vector3.ZERO, decel * delta)
	
	$probecast.look_at(player.global_position)
	if $probecast.is_colliding():
		if $probecast.get_collider().is_in_group("player"):
			tracking = true
			look_at(player.global_position)
			global_position.move_toward(player.global_position, speed * delta)
			velocity = -transform.basis.z * speed
	
	if tracking == false: #idle
		$AnimationPlayer.play("idle 2.0")
		rotation.y += 1 * delta
	else:
		$AnimationPlayer.stop()
	
	move_and_slide()

func hit(dmg):
	health -= dmg
	if health <= 0:
		die()
	$probecast.target_position.z -= 5
	print($probecast.target_position.z)
	$hitsound.play()
	
#	alert_others()

func die():
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		#player.hit(damage)
		player.die()
		queue_free()
