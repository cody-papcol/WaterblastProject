extends Node

const SAVE_PATH = "user://save.json"

var highest_level_unlocked = 1

var recent_score = 0

var scores: Array = []

func _ready():
	load_progress()


func unlock_level(level: int):
	if level > highest_level_unlocked:
		highest_level_unlocked = level
		save_progress()


func save_progress():
	var save_data = {
		"highest_level_unlocked": highest_level_unlocked,
		"scores": scores,
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
		scores = save_data.get("scores", [])
		print(ProjectSettings.globalize_path(SAVE_PATH))

func add_score(value):
	recent_score = value
	
func append_score(username):
	scores.append({"username": username, "score": recent_score})
	
	scores.sort_custom(func(a, b):
		return a["score"] > b["score"]
	)
	

func delete_save():
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(SAVE_PATH))
		
		scores = []
		highest_level_unlocked = 1
		
		print("Save deleted")
	else:
		print("No save file found")
