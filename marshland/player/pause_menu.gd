extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/sense/HSlider.value = Global.sense * 1000 * 1000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		if Global.in_menu == false:
			show()
			Global.in_menu = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			hide()
			Global.in_menu = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_h_slider_value_changed(value: float) -> void:
	Global.sense = (value * 0.001) / 1000
