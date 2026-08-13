extends Node3D

@onready var alien_prefab = preload("res://prefabs/alien.tscn")
@onready var spawns: Array = [$Spawner1, $Spawner2, $Spawner3, $Spawner4]
@onready var player = $Player

var spawnLocation: int = 0
var playerCoins = 0



func _on_test_enemy_spawn_timer_timeout() -> void:
	spawnLocation = randi_range(0, 3)
	var alien: CharacterBody3D = alien_prefab.instantiate()
	alien.transform = spawns[spawnLocation].transform
	add_child(alien)
