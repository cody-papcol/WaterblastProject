extends Node

const SAVE_PATH = "user://save.json"

var highest_level_unlocked = 1

var recent_score = 0

var levelOneScores: Array = []
var levelTwoScores: Array = []
var levelThreeScores: Array = []
var levelFourScores: Array = []
var levelFiveScores: Array = []

func _ready():
	load_progress()


func unlock_level(level: int):
	if level > highest_level_unlocked:
		highest_level_unlocked = level
		save_progress()


func save_progress():
	var save_data = {
		"highest_level_unlocked": highest_level_unlocked,
		"levelOneScores": levelOneScores,
		"levelTwoScores": levelTwoScores,
		"levelThreeScores": levelThreeScores,
		"levelFourScores": levelFourScores,
		"levelFiveScores": levelFiveScores,
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))


func load_progress():
	if not FileAccess.file_exists(SAVE_PATH):
		print('no save present')
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var save_data = JSON.parse_string(file.get_as_text())

	if save_data:
		highest_level_unlocked = save_data.get("highest_level_unlocked", 1)
		levelOneScores = save_data.get("levelOneScores", [])
		levelTwoScores = save_data.get("levelTwoScores", [])
		levelThreeScores = save_data.get("levelThreeScores", [])
		levelFourScores = save_data.get("levelFourScores", [])
		levelFiveScores = save_data.get("levelFiveScores", [])
		print(ProjectSettings.globalize_path(SAVE_PATH))
		
		print(highest_level_unlocked)

func add_score(value):
	recent_score = value
	
func append_score(username, level):
	
	# saves scores for each level individually so each level has its own leaderboard
	if level == 1:
		levelOneScores.append({"username": username, "score": recent_score})
		levelOneScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
	elif level == 2:
		levelTwoScores.append({"username": username, "score": recent_score})
		levelTwoScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
	elif level == 3:
		levelThreeScores.append({"username": username, "score": recent_score})
		levelThreeScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
	elif level == 4:
		levelFourScores.append({"username": username, "score": recent_score})
		levelFourScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
	elif level == 5:
		levelFiveScores.append({"username": username, "score": recent_score})
		levelFiveScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
	
	
	
	

func delete_save():
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(SAVE_PATH))
		
		levelOneScores = []
		levelTwoScores = []
		levelThreeScores = []
		levelFourScores = []
		levelFiveScores = []
		highest_level_unlocked = 1
		
		print("Save deleted")
	else:
		print("No save file found")
