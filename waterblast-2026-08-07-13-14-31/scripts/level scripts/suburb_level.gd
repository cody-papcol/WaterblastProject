extends Node3D


@onready var alien_prefab = preload("res://prefabs/alien.tscn")
@onready var spawns: Array = [$AlienSpawnLocations/Spawn1, $AlienSpawnLocations/Spawn2, $AlienSpawnLocations/Spawn3, $AlienSpawnLocations/Spawn4]
@onready var player = $Player

var spawnLocation: int = 0
var playerCoins = 0



func _on_test_enemy_spawn_timer_timeout() -> void:
	spawnLocation = randi_range(0, 3)
	var alien: CharacterBody3D = alien_prefab.instantiate()
	alien.transform = spawns[spawnLocation].transform
	add_child(alien)
	
	# adding player collision exception with alien
	player.blocking.add_exception(alien)
