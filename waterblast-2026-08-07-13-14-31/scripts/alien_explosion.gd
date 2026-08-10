extends Node3D



func _on_death_timer_timeout() -> void:
	queue_free()
