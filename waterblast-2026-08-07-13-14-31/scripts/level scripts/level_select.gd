extends Control

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if SaveManager.highest_level_unlocked > 1:
		$"Level 2 Locked".visible = false
		
	if SaveManager.highest_level_unlocked > 2:
		$"Level 3 Locked".visible = false
		
	if SaveManager.highest_level_unlocked > 3:
		$"Level 4 Locked".visible = false
		
	if SaveManager.highest_level_unlocked > 4:
		$"Level 5 Locked".visible = false
		

func _on_back_pressed():
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")


func _on_level_1_pressed():
	if SaveManager.highest_level_unlocked > 0:
		get_tree().change_scene_to_file("res://levels/test_level.tscn")


func _on_level_2_pressed():
	if SaveManager.highest_level_unlocked > 1:
		get_tree().change_scene_to_file("res://levels/suburb_level.tscn")


func _on_level_3_pressed():
	if SaveManager.highest_level_unlocked > 2:
		get_tree().change_scene_to_file("res://levels/supermarket_level.tscn")


func _on_level_4_pressed():
	if SaveManager.highest_level_unlocked > 3:
		get_tree().change_scene_to_file("res://levels/milbase_level.tscn")


func _on_level_5_pressed():
	if SaveManager.highest_level_unlocked > 4:
		get_tree().change_scene_to_file("res://levels/suburb_level.tscn")
