extends Node3D


@onready var alien_prefab = preload("res://prefabs/alien.tscn")
@onready var spawns: Array = [$AlienSpawnLocations/Spawn1, $AlienSpawnLocations/Spawn2, $AlienSpawnLocations/Spawn3, $AlienSpawnLocations/Spawn4]
@onready var player = $Player

var spawnLocation: int = 0
var playerCoins = 0

var waveNum = 5
var leftInWave = 0

var enemyNum = 0


func _on_test_enemy_spawn_timer_timeout() -> void:
	if enemyNum < 50:
		_spawn_enemy()

func enemy_death():
	enemyNum += -1
	print(enemyNum)
	
	if enemyNum == 0:
		print('wave ended')
	
func _spawn_enemy():
	spawnLocation = randi_range(0, 3)
	var alien: CharacterBody3D = alien_prefab.instantiate()
	alien.transform = spawns[spawnLocation].transform
	alien.connect("death", enemy_death)
	add_child(alien)
	enemyNum += 1
	
	# adding player collision exception with alien
	player.blocking.add_exception(alien)
