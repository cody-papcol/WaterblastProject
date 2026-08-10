extends CharacterBody3D

class_name enemy

@export var MoveSpeed: float = 4.0
@export var AttackReach: float = 1.7

@onready var alienExplosionPrefab = preload("res://prefabs/alien_explosion.tscn")
@onready var alienDamageSoundPrefab = preload("res://prefabs/alien_damage_sound.tscn")

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var DamageTimer: Timer = $DamageTimer
@onready var damageSound: AudioStreamPlayer3D = $DamageSoundPlayer

var health: int = 100
var player: CharacterBody3D = null

var canDamage = true

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	
func _process(_delta: float) -> void:
	nav_agent.set_target_position(player.global_position)
	
	if global_position.distance_to(player.global_position) < AttackReach and canDamage:
		var attack: Attack = Attack.new(10.0, self)
		player.HealthComponent.damage(attack)
		canDamage = false
		DamageTimer.start()
		
func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return
		
	var next_position: Vector3 = nav_agent.get_next_path_position()
	velocity = global_position.direction_to(next_position) * MoveSpeed
	
	move_and_slide()

func damage(amount):
	
	damageSound.play()
	
	health += -amount
	
	if health <= 0:
		
		player.playerCoins += 1
		
		var explosion = alienExplosionPrefab.instantiate()
		explosion.transform = transform
		get_parent().add_child(explosion)
		
		var damageSound = alienDamageSoundPrefab.instantiate()
		damageSound.transform = transform
		get_parent().add_child(damageSound)
		
		queue_free()


func _on_damage_timer_timeout() -> void:
	canDamage = true
