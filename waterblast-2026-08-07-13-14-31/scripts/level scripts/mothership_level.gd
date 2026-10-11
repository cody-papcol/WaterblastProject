extends Node3D

@onready var alien_prefab = preload("res://prefabs/alien.tscn")
@onready var spawns: Array = [$AlienSpawnLocations/Spawn1, $AlienSpawnLocations/Spawn2]
@onready var initialAliens: Array = [$InitialAliens/Alien, $InitialAliens/Alien2]
@onready var player = $Player
@onready var waveResetTimer = $WaveResetTimer
@onready var alienBoss = $Alien

var spawnLocation: int = 0
var playerCoins = 0

var waveNum = 0
var targetEnemyNum = 6.0
var spawnedEnemies = 6.0
var spawnInterval = 3.0
var kills = 0

var totalWaveNum = 1

var enemyNum = 6.0


func _ready():
	player.level = 5
	player.infiniteWater = true
	player.leftInWave = enemyNum
	player.totalWaves = totalWaveNum
	
	if CurrentLevelManager.endless_mode:
		player.availableUnlocks = 10
		alienBoss.queue_free()
	else:
		player.availableUnlocks = 4
	CurrentLevelManager.current_level = 5
	
func _process(delta: float) -> void:
	if targetEnemyNum:
		player.WaveProgress.value = enemyNum/targetEnemyNum

func enemy_death():
	enemyNum += -1
	kills += 1
	player.leftInWave = targetEnemyNum - kills
	
	if enemyNum == 0 and spawnedEnemies == targetEnemyNum:
		waveResetTimer.start()
		print("start timer")
	
func _spawn_enemy():
	
	print('enemy spawned')
	
	spawnLocation = randi_range(0, 1)
	var alien: CharacterBody3D = alien_prefab.instantiate()
	alien.transform = spawns[spawnLocation].transform
	alien.connect("death", enemy_death)
	
	alien.healthMulti = 5.0
	
	add_child(alien)
	
	
	# adding player collision exception with alien
	player.blocking.add_exception(alien)

func _start_wave(num):
	
	# adding one value to the enemy number and starting spawning process
	
	num += 1
	waveNum = num
	player.wave = waveNum
	spawnedEnemies = 0
	kills = 0
	targetEnemyNum = num * 50000
	
	player.leftInWave = targetEnemyNum
	
	# enemy spawning
	for x in targetEnemyNum:
		enemyNum += 1
		spawnedEnemies += 1
		_spawn_enemy()
		if is_inside_tree():
			await get_tree().create_timer(spawnInterval, false).timeout
	
	if spawnedEnemies == targetEnemyNum:
		print('wave ready')


func _on_wave_reset_timer_timeout():
	if not CurrentLevelManager.endless_mode:
		if waveNum + 1 <= totalWaveNum:
			_start_wave(waveNum)
		else:
			if SaveManager.highest_level_unlocked == 4:
				SaveManager.highest_level_unlocked += 1
				SaveManager.save_progress()
				get_tree().change_scene_to_file("res://levels/level_select.tscn")
			else:
				get_tree().change_scene_to_file("res://levels/level_select.tscn")
	else:
		_start_wave(waveNum)


func _on_boss_alien_death():
	player.beat_game()
	await get_tree().create_timer(5, false).timeout
	get_tree().change_scene_to_file("res://levels/level_select.tscn")
