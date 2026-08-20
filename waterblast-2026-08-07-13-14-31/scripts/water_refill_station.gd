extends StaticBody3D

@onready var prompt_label:Label3D = $Label3D
@onready var player: CharacterBody3D = $"../Player"

func interact():
	player.refill_water()
	print('refill')

func show_prompt():
	prompt_label.visible = true
	
func hide_prompt():
	prompt_label.visible = false
