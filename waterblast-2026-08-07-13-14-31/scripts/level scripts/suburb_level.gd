extends Node3D


@onready var alien_prefab = preload("res://prefabs/alien.tscn")
@onready var spawns: Array = [$AlienSpawnLocations/Spawn1, $AlienSpawnLocations/Spawn2, $AlienSpawnLocations/Spawn3, $AlienSpawnLocations/Spawn4]
@onready var player = $Player
@onready var waveResetTimer = $WaveResetTimer

var spawnLocation: int = 0
var playerCoins = 0

var waveNum = 0
var targetEnemyNum = 4.0
var spawnedEnemies = 4.0

var totalWaveNum = 2

var enemyNum = 4.0


func _ready():
	
	player.level = 2
	player.unlockedWeapons = 2

func _process(delta: float) -> void:
	if targetEnemyNum:
		player.WaveProgress.value = enemyNum/targetEnemyNum
	
func enemy_death():
	enemyNum += -1
	
	if enemyNum == 0 and spawnedEnemies == targetEnemyNum:
		print('wave ended')
		print(enemyNum)
		waveResetTimer.start()
	
func _spawn_enemy():
	
	print('enemy spawned')
	
	spawnLocation = randi_range(0, 3)
	var alien: CharacterBody3D = alien_prefab.instantiate()
	alien.transform = spawns[spawnLocation].transform
	alien.connect("death", enemy_death)
	add_child(alien)
	
	
	# adding player collision exception with alien
	player.blocking.add_exception(alien)

func _start_wave(num):
	
	# adding one value to the enemy number and starting spawning process
	
	num += 1
	waveNum = num
	spawnedEnemies = 0
	targetEnemyNum = num * 8
	
	# enemy spawning
	for x in targetEnemyNum:
		enemyNum += 1
		spawnedEnemies += 1
		_spawn_enemy()
		await get_tree().create_timer(0.5).timeout


func _on_wave_reset_timer_timeout():
	if waveNum + 1 <= totalWaveNum:
		_start_wave(waveNum)
	else:
		SaveManager.highest_level_unlocked += 1
		SaveManager.save_progress()
		get_tree().change_scene_to_file("res://levels/supermarket_level.tscn")
