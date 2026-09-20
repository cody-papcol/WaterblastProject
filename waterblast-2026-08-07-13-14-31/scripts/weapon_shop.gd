extends StaticBody3D

@onready var prompt_label:Label3D = $Label3D
@onready var player: CharacterBody3D = $"../Player"

func interact():
	print(player.in_shop)
	if player.in_shop:
		player.close_shop()
	else:
		player.open_shop()

func show_prompt():
	prompt_label.visible = true
	
func hide_prompt():
	prompt_label.visible = false
