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

var totalWaveNum = 5

var enemyNum = 5.0


func _ready():
	player.level = 3
	player.unlockedWeapons = 3
	CurrentLevelManager.current_level = 3
	
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
	targetEnemyNum = num * 5
	
	print("wave started")
	
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
		get_tree().change_scene_to_file("res://levels/milbase_level.tscn")
