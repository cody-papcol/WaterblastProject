extends Node3D

@onready var alien_prefab = preload("res://prefabs/alien.tscn")
@onready var spawns: Array = [$AlienSpawnLocations/Spawn1, $AlienSpawnLocations/Spawn2, $AlienSpawnLocations/Spawn3]
@onready var initialAliens: Array = [$InitialAliens/Alien, $InitialAliens/Alien2]
@onready var player = $Player
@onready var waveResetTimer = $WaveResetTimer

var spawnLocation: int = 0
var playerCoins = 0

var waveNum = 0
var targetEnemyNum = 2.0
var spawnedEnemies = 2.0

var totalWaveNum = 10

var enemyNum = 2.0


func _ready():
	player.level = 4
	player.unlockedWeapons = 4
	CurrentLevelManager.current_level = 4
	
func _process(delta: float) -> void:
	if targetEnemyNum:
		player.WaveProgress.value = enemyNum/targetEnemyNum

func enemy_death():
	enemyNum += -1
	
	if enemyNum == 0 and spawnedEnemies == targetEnemyNum:
		waveResetTimer.start()
		print("start timer")
	
func _spawn_enemy():
	
	print('enemy spawned')
	
	spawnLocation = randi_range(0, 2)
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
	targetEnemyNum = num * 50
	
	print("wave started")
	
	# enemy spawning
	for x in targetEnemyNum:
		enemyNum += 1
		spawnedEnemies += 1
		_spawn_enemy()
		await get_tree().create_timer(0.5).timeout
	
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
