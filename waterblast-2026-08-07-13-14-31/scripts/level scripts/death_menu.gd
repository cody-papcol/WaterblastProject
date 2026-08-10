extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/test_level.tscn")
	


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
