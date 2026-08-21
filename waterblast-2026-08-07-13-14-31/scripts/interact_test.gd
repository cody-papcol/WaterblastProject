extends StaticBody3D

@onready var prompt_label:Label3D = $Label3D
@onready var player: CharacterBody3D = $"../Player"
@onready var respawnTimer: Timer = $RespawnTimer

func interact():
	player._damage(-50)
	visible = false
	respawnTimer.start()


func show_prompt():
	prompt_label.visible = true
	
func hide_prompt():
	prompt_label.visible = false


func _on_respawn_timer_timeout() -> void:
	visible = true
