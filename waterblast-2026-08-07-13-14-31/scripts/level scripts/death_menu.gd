extends Control

var hasEnteredName: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	display_leaderboard()
	
	if CurrentLevelManager.endless_mode == true:
		$Leaderboard.visible = true
	else:
		$Leaderboard.visible = false
	

func _on_play_button_pressed() -> void:
	if CurrentLevelManager.current_level == 1:
		get_tree().change_scene_to_file("res://levels/test_level.tscn")
	elif CurrentLevelManager.current_level == 2:
		get_tree().change_scene_to_file("res://levels/suburb_level.tscn")
	elif CurrentLevelManager.current_level == 3:
		get_tree().change_scene_to_file("res://levels/supermarket_level.tscn")
	elif CurrentLevelManager.current_level == 4:
		get_tree().change_scene_to_file("res://levels/milbase_level.tscn")
	elif CurrentLevelManager.current_level == 5:
		get_tree().change_scene_to_file("res://levels/mothership_level.tscn")
	


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")


func _on_line_edit_text_submitted(new_text):
	
	
	
	if hasEnteredName == false:
		SaveManager.append_score(new_text, CurrentLevelManager.current_level)
		display_leaderboard()
		hasEnteredName = true
	
func display_leaderboard():
	
	var value = 1
	var currentLeaderboard: Array
	
	
	# choosing which leaderboard to display based on current level
	if CurrentLevelManager.current_level == 1:
		currentLeaderboard = SaveManager.levelOneScores
	if CurrentLevelManager.current_level == 2:
		currentLeaderboard = SaveManager.levelTwoScores
	if CurrentLevelManager.current_level == 3:
		currentLeaderboard = SaveManager.levelThreeScores
	if CurrentLevelManager.current_level == 4:
		currentLeaderboard = SaveManager.levelFourScores
	if CurrentLevelManager.current_level == 5:
		currentLeaderboard = SaveManager.levelFiveScores
	
	for s in currentLeaderboard:
		if get_node('Leaderboard/Leaderboard' + str(value)):
			var boardLabel: Label = get_node('Leaderboard/Leaderboard' + str(value))
			boardLabel.text = s["username"] + ": " + str(s["score"])
			value += 1
	
	SaveManager.save_progress()
