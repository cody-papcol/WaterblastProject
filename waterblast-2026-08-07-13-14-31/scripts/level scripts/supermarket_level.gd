extends Node3D

@onready var alien_prefab = preload("res://prefabs/alien.tscn")
@onready var spawns: Array = [$AlienSpawnLocations/Spawn1, $AlienSpawnLocations/Spawn2, $AlienSpawnLocations/Spawn3]
@onready var initialAliens: Array = [$InitialAliens/Alien, $InitialAliens/Alien2, $InitialAliens/Alien3, $InitialAliens/Alien4, $InitialAliens/Alien5]
@onready var player = $Player
@onready var waveResetTimer = $WaveResetTimer

var spawnLocation: int = 0
var playerCoins = 0

var waveNum = 0
var targetEnemyNum = 5.0
var spawnedEnemies = 5.0
var spawnInterval = 1.0
var leftToIncrease = 5
var enemyHealthMulti = 1
var kills = 0

## The multiplier of enemies that spawn each wave; eg Wave 5 will have 5 x (this value) enemies. default 10
@export var enemyMulti = 6
@export var totalWaveNum = 20
@export var playerMaxReserveWater = 100

var enemyNum = 5.0


func _ready():
	player.level = 3
	player.infiniteWater = false
	player.leftInWave = enemyNum
	player.totalWaves = totalWaveNum
	
	if CurrentLevelManager.endless_mode:
		playerMaxReserveWater = 500
		player.availableUnlocks = 4
	else:
		player.availableUnlocks = 2
	CurrentLevelManager.current_level = 3
	
	player.max_total_water = playerMaxReserveWater
	player.refill_water()
	
	
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
	
	spawnLocation = randi_range(0, 2)
	var alien: CharacterBody3D = alien_prefab.instantiate()
	alien.transform = spawns[spawnLocation].transform
	alien.connect("death", enemy_death)
	
	if CurrentLevelManager.endless_mode:
		alien.healthMulti = enemyHealthMulti
	else:
		if waveNum >= 3:
			alien.healthMulti = 1.5
		if waveNum >= 6:
			alien.healthMulti = 2.0
		if waveNum >= 9:
			alien.healthMulti = 3.0
	
	add_child(alien)
	print(alien.health)
	
	# adding player collision exception with alien
	player.blocking.add_exception(alien)

func _start_wave(num):
	
	# adding one value to the enemy number and starting spawning process
	
	num += 1
	waveNum = num
	player.wave = waveNum
	spawnedEnemies = 0
	kills = 0
	targetEnemyNum = num * enemyMulti
	
	if not CurrentLevelManager.endless_mode:
		if waveNum == 3:
			player.enemy_health_increase()
		elif waveNum == 6:
			player.enemy_health_increase()
		elif waveNum == 9:
			player.enemy_health_increase()
	
	player.leftInWave = targetEnemyNum
	
	# enemy spawning
	for x in targetEnemyNum:
		enemyNum += 1
		spawnedEnemies += 1
		_spawn_enemy()
		if is_inside_tree():
			await get_tree().create_timer(spawnInterval, false).timeout


func _on_wave_reset_timer_timeout():
	if not CurrentLevelManager.endless_mode:
		
		
		if waveNum + 1 <= totalWaveNum:
			_start_wave(waveNum)
		else:
			if SaveManager.highest_level_unlocked == 3:
				
				player.max_water_increase()
				await get_tree().create_timer(5).timeout
			
				SaveManager.highest_level_unlocked += 1
				SaveManager.save_progress()
				get_tree().change_scene_to_file("res://levels/level_select.tscn")
			else:
				get_tree().change_scene_to_file("res://levels/level_select.tscn")
	else:
		if leftToIncrease > 0:
			leftToIncrease += -1
		else:
			player.enemy_health_increase()
			enemyHealthMulti += 0.5
			leftToIncrease = 4
		_start_wave(waveNum)
