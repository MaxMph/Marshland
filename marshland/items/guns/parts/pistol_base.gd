extends Node3D

@export var barrel: PackedScene
@export var mag: PackedScene
@export var stock: PackedScene

@onready var bullet = preload("res://items/guns/bullet.tscn")
@onready var main =  get_tree().get_first_node_in_group("world") #get_tree().root

var v_recoil = 0.2
var h_recoil = 0.06
var recoil_speed = 2
var rest_speed = 4

var goal_rot

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	
	rotation.x = lerp(rotation.x, 0.0, 6 * delta)
		#pass
	#if rotation 
	
	#if rotation != Vector3.ZERO:
		#rotation.x = move_toward(rotation.x, 0, rest_speed * delta)
		#rotation.move_toward(Vector3.ZERO, 1)
		#rotation.move_toward(Vector3.ZERO, rest_speed * delta)
		#print("ggggggggggg")
	#else:

func attack():
	var new_bullet = bullet.instantiate()
	new_bullet.spawn_transform = $bullet_marker.global_transform
	$bullet_marker/Sprite3D.rotation.z = randi_range(-20, 20)
	#$AnimationPlayer.play("shoot")
	main.add_child.call_deferred(new_bullet)
	$bullet_marker/Sprite3D.show()
	recoil()
	$AnimationPlayer.play("shoot")
	await get_tree().create_timer(0.04).timeout
	$bullet_marker/Sprite3D.hide()
	#$shoot.play()

func recoil():
	rotation.x = 0.1
	#goal_rot = rotation + Vector3(v_recoil, h_recoil, 0)
	#rotation += Vector3(v_recoil, randf_range(-h_recoil, h_recoil), 0)
	#goal_rot = rotation + Vector3(randf_range(-v_recoil, v_recoil), randf_range(-v_recoil, v_recoil), randf_range(-v_recoil, v_recoil))
	
	get_tree().get_first_node_in_group("player").recoil(Vector3(v_recoil, randf_range(-h_recoil, h_recoil), 0))
