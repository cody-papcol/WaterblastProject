extends StaticBody3D

@onready var prompt_label:Label3D = $Label3D
@onready var player: CharacterBody3D = $"../Player"
@onready var respawnTimer: Timer = $RespawnTimer


func show_prompt():
	prompt_label.visible = true
	
func hide_prompt():
	prompt_label.visible = false


func _on_respawn_timer_timeout() -> void:
	visible = true


func _on_area_3d_body_entered(body):
	if visible and body is player and player.health < player.maxHealth:
		player._damage(-50)
		visible = false
		respawnTimer.start()
