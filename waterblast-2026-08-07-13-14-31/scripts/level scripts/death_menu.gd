extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE



func _on_play_button_pressed() -> void:
	if CurrentLevelManager.current_level == 1:
		get_tree().change_scene_to_file("res://levels/test_level.tscn")
	elif CurrentLevelManager.current_level == 2:
		get_tree().change_scene_to_file("res://levels/suburb_level.tscn")
	elif CurrentLevelManager.current_level == 3:
		get_tree().change_scene_to_file("res://levels/supermarket_level.tscn")
	elif CurrentLevelManager.current_level == 4:
		get_tree().change_scene_to_file("res://levels/milbase_level.tscn")
	


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
