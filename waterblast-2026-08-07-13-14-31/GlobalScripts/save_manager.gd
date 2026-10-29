extends Node

const SAVE_PATH = "user://save.json"

var highest_level_unlocked = 5

var recent_score = 0

var levelOneScores: Array = []
var levelTwoScores: Array = []
var levelThreeScores: Array = []
var levelFourScores: Array = []
var levelFiveScores: Array = []

# loads the save
func _ready():
	load_progress()
	print(ProjectSettings.globalize_path(SAVE_PATH))

# unlocks the next level if player has beaten previous level
func unlock_level(level: int):
	if level > highest_level_unlocked:
		highest_level_unlocked = level
		save_progress()

# saves the player progress as arrays of dictionaries.
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
	
	if FileAccess.file_exists(SAVE_PATH):
		print('save successful')

# loads the player progress if there is a file present, and sets the score and unlocked levels
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

# makes the recent score value the most recent score by the player
func add_score(value):
	recent_score = value
	
# adds the most recent score to the appropriate scores array depending on the current level
func append_score(username, level):
	
	# saves scores for each level individually so each level has its own leaderboard
	if level == 1:
		levelOneScores.append({"username": username, "score": recent_score})
		levelOneScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
		if levelOneScores.size() > 10:
			levelOneScores = levelOneScores.slice(0, 10)
	elif level == 2:
		levelTwoScores.append({"username": username, "score": recent_score})
		levelTwoScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
		if levelTwoScores.size() > 10:
			levelTwoScores = levelTwoScores.slice(0, 10)
	elif level == 3:
		levelThreeScores.append({"username": username, "score": recent_score})
		levelThreeScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
		if levelThreeScores.size() > 10:
			levelThreeScores = levelThreeScores.slice(0, 10)
	elif level == 4:
		levelFourScores.append({"username": username, "score": recent_score})
		levelFourScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
		if levelFourScores.size() > 10:
			levelFourScores = levelFourScores.slice(0, 10)
	elif level == 5:
		levelFiveScores.append({"username": username, "score": recent_score})
		levelFiveScores.sort_custom(func(a, b):
			return a["score"] > b["score"]
		)
		if levelFiveScores.size() > 10:
			levelFiveScores = levelFiveScores.slice(0, 9)
	
	
	
	
# removes the save file
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
