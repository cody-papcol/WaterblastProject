extends StaticBody3D

@onready var prompt_label:Label3D = $Label3D
@onready var player: CharacterBody3D = $"../Player"

# called if player interacts, opens or hides the shop
func interact():
	print('interacted')
	if player.in_shop == false:
		player.open_shop()
	else:
		player.close_shop()
		

# shows the interact label
func show_prompt():
	prompt_label.visible = true
	
# hides the interact label
func hide_prompt():
	prompt_label.visible = false
