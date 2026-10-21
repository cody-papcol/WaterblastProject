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
var spawnInterval = 1.0
var leftToIncrease = 5
var enemyHealthMulti = 1
var kills = 0

@export var enemyMulti = 5
@export var totalWaveNum = 1
@export var playerMaxReserveWater = 100

var enemyNum = 4.0

# sets all values, including player values for start of level
func _ready():
	
	MusicManager.stop_music()
	
	player.level = 1
	player.infiniteWater = false
	player.leftInWave = enemyNum
	player.totalWaves = totalWaveNum
	
	# if in endless mode player gets increased total water (consistent across levels)
	if CurrentLevelManager.endless_mode:
		player.availableUnlocks = 4
		playerMaxReserveWater = 500
	else:
		player.availableUnlocks = 0
	CurrentLevelManager.current_level = 1

	player.max_total_water = playerMaxReserveWater
	player.refill_water()
	
# called every frame, only sets the wave progress bar
func _process(delta: float) -> void:
	
	if targetEnemyNum:
		player.WaveProgress.value = enemyNum/targetEnemyNum
		

# called when an enemy dies, increases the kills, decreases the amount of enemies left in the wave,
# calls the wave reset timer if it was the last enemy
func enemy_death():
	enemyNum += -1
	kills += 1
	player.leftInWave = targetEnemyNum - kills
	
	if enemyNum == 0 and spawnedEnemies == targetEnemyNum:
		print('wave ended')
		waveResetTimer.start()
	
# controls the spawning of the enemies
func _spawn_enemy():
	
	# selects the spawn locations and spawns an enemy
	spawnLocation = randi_range(0, 3)
	var alien: CharacterBody3D = alien_prefab.instantiate()
	alien.transform = spawns[spawnLocation].transform
	alien.connect("death", enemy_death)
	
	# sets the alien health depending on if endless mode or not
	if CurrentLevelManager.endless_mode:
		alien.healthMulti = enemyHealthMulti
	elif waveNum >= 3:
		alien.healthMulti = 1.5
	
	add_child(alien)
	
	
	# adding player collision exception with alien
	player.blocking.add_exception(alien)

func _start_wave(num):
	
	# adding one value to the enemy number and starting spawning process
	
	print('wave started')
	
	num += 1
	waveNum = num
	player.wave = waveNum
	spawnedEnemies = 0
	kills = 0
	targetEnemyNum = num * enemyMulti
	
	# warns player of increased health of enemies
	if waveNum == 3 and CurrentLevelManager.endless_mode == false:
		player.enemy_health_increase()
	
	player.leftInWave = targetEnemyNum
	
	# enemy spawning
	for x in targetEnemyNum:
		enemyNum += 1
		spawnedEnemies += 1
		_spawn_enemy()
		if is_inside_tree():
			await get_tree().create_timer(spawnInterval, false).timeout

# this function activates the next wave or, if there are no waves left, tells player
# that their max total water has increased and updates the level
func _on_wave_reset_timer_timeout() -> void:
	if not CurrentLevelManager.endless_mode:
		if waveNum + 1 <= totalWaveNum:
			_start_wave(waveNum)
		else:
			
			player.max_water_increase()
			await get_tree().create_timer(5).timeout
			
			if SaveManager.highest_level_unlocked == 1:
				SaveManager.highest_level_unlocked += 1
				SaveManager.save_progress()
				get_tree().change_scene_to_file("res://levels/level_select.tscn")
			else:
				get_tree().change_scene_to_file("res://levels/level_select.tscn")
	
	# if not endless mode, updates the wave number
	else:
		if leftToIncrease > 0:
			leftToIncrease += -1
		else:
			player.enemy_health_increase()
			enemyHealthMulti += 0.5
			leftToIncrease = 4
		_start_wave(waveNum)
