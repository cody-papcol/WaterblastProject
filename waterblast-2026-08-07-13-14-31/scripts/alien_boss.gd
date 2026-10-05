extends CharacterBody3D

class_name boss

signal death

@export var MoveSpeed: float = 4.0
@export var AttackReach: float = 1.7

@onready var alienExplosionPrefab = preload("res://prefabs/alien_explosion.tscn")
@onready var alienDamageSoundPrefab = preload("res://prefabs/alien_damage_sound.tscn")
@onready var alienDeathSoundPrefab = preload("res://prefabs/alien_death_sound.tscn")
@onready var boss_bullet_prefab = preload("res://prefabs/boss_bullet.tscn")

@onready var DamageTimer: Timer = $DamageTimer
@onready var damageSound: AudioStreamPlayer3D = $DamageSoundPlayer
@onready var mesh: Node3D = $"character-g2"
@onready var meshAnims: AnimationPlayer = $"character-g2/AnimationPlayer"
@onready var head: MeshInstance3D = $"character-g2/character-g/root/torso/head"
@onready var shootTimer: Timer = $ShootTimer

@export var health: int = 2000
var player: CharacterBody3D = null

var nextPosition

var canDamage = true
var bulletVelocity = 30.0

var running = false

var isAlive = true


func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	
func _process(_delta: float) -> void:
	
	look_at(Vector3(player.position.x, global_position.y, player.position.z))
	head.look_at(Vector3(player.position.x, player.global_position.y, player.position.z))
	if isAlive:
		
		
		if global_position.distance_to(player.global_position) < AttackReach and canDamage:
			var attack: Attack = Attack.new(50.0, self)
			player.HealthComponent.damage(attack)
			canDamage = false
			
			# attack animation
			look_at(Vector3(player.position.x, global_position.y, player.position.z))
			meshAnims.play("attack-melee-right")
			
			DamageTimer.start()
	
func damage(amount):
	
	
	if isAlive:
		health += -amount
	
	if health <= 0 and isAlive == true:
		
		isAlive = false
		$CollisionShape3D.disabled = true
		damageSound.play()
		
		meshAnims.play("die")
		
		player.playerCoins += 1
		
		death.emit()
		
		player.enemy_kill()
		
		await get_tree().create_timer(1, false).timeout
		
		
		
		var explosion = alienExplosionPrefab.instantiate()
		explosion.transform = transform
		get_parent().add_child(explosion)
		
		var damageSound = alienDamageSoundPrefab.instantiate()
		damageSound.transform = transform
		get_parent().add_child(damageSound)
		
		queue_free()
	else:
		var deathSound = alienDeathSoundPrefab.instantiate()
		deathSound.transform = transform
		get_parent().add_child(deathSound)


func _on_damage_timer_timeout() -> void:
	canDamage = true


func _on_shoot_timer_timeout():
	var new_bullet : RigidBody3D = boss_bullet_prefab.instantiate()
	new_bullet.global_transform = $"character-g2/character-g/root/torso/head".global_transform
	new_bullet.apply_impulse($"character-g2/character-g/root/torso/head".global_transform.basis.z * -bulletVelocity)
	new_bullet.add_collision_exception_with($".")
	new_bullet.add_collision_exception_with(new_bullet)
	get_parent().add_child(new_bullet)
