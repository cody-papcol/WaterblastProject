extends StaticBody3D

@onready var prompt_label:Label3D = $Label3D
@onready var player: CharacterBody3D = $"../Player"

func interact():
	print('interacted')
	if player.in_shop == false:
		player.open_shop()
	else:
		player.close_shop()

func show_prompt():
	prompt_label.visible = true
	
func hide_prompt():
	prompt_label.visible = false
