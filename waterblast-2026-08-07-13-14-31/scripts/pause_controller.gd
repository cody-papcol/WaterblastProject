extends Node3D

@onready var player = $".."

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		if player.in_shop:
			player.close_shop()
		else: 
			get_tree().paused = not get_tree().paused
			
			if get_tree().paused == true:
				
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				$"../HUD/Control/PauseBackground".visible = true
				
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				$"../HUD/Control/PauseBackground".visible = false
			
			# fixing player sprint animation issues
			if get_tree().paused == true and player.sprinting == true:
				$"../AnimationPlayer".play_backwards("sprint")


func _on_resume_button_pressed():
	
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$"../HUD/Control/PauseBackground".visible = false


func _on_quit_button_pressed():
	get_tree().paused = false
	
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
