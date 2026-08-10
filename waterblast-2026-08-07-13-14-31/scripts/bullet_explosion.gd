extends Node3D

func _ready() -> void:
	$SplashAudioPlayer.play()
func _on_timer_timeout() -> void:
	queue_free()
