extends Node3D
var fade_time = 0.01

func _ready() -> void:
	await get_tree().create_timer(fade_time).timeout
	queue_free()
