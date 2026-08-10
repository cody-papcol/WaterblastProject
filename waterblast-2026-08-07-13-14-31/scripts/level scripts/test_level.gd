extends Node3D

@onready var alien_prefab = preload("res://prefabs/alien.tscn")
@onready var spawns: Array = [$Spawner1, $Spawner2, $Spawner3, $Spawner4]
@onready var player = $Player

var spawnLocation: int = 0
var playerCoins = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://levels/main_menu.tscn")
		


func _on_test_enemy_spawn_timer_timeout() -> void:
	spawnLocation = randi_range(0, 3)
	var alien: CharacterBody3D = alien_prefab.instantiate()
	alien.transform = spawns[spawnLocation].transform
	add_child(alien)
