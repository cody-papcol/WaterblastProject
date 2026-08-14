extends CharacterBody3D

class_name enemy

@export var MoveSpeed: float = 4.0
@export var AttackReach: float = 1.7

@onready var alienExplosionPrefab = preload("res://prefabs/alien_explosion.tscn")
@onready var alienDamageSoundPrefab = preload("res://prefabs/alien_damage_sound.tscn")
@onready var alienDeathSoundPrefab = preload("res://prefabs/alien_death_sound.tscn")

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var DamageTimer: Timer = $DamageTimer
@onready var damageSound: AudioStreamPlayer3D = $DamageSoundPlayer
@onready var mesh: Node3D = $"character-g2"
@onready var meshAnims: AnimationPlayer = $"character-g2/AnimationPlayer"

var health: int = 100
var player: CharacterBody3D = null

var canDamage = true

var running = false

var isAlive = true


func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	
func _process(_delta: float) -> void:
	
	if isAlive:
	
		nav_agent.set_target_position(player.global_position)
		
		look_at(Vector3(player.position.x, global_position.y, player.position.z))
		
		if global_position.distance_to(player.global_position) < AttackReach and canDamage:
			var attack: Attack = Attack.new(10.0, self)
			player.HealthComponent.damage(attack)
			canDamage = false
			
			# attack animation
			meshAnims.play("attack-melee-right")
			
			DamageTimer.start()
		
func _physics_process(_delta: float) -> void:
	
	if isAlive:
		if nav_agent.is_navigation_finished():
			return
		if not global_position.distance_to(player.global_position) < AttackReach:
			var next_position: Vector3 = nav_agent.get_next_path_position()
			velocity = global_position.direction_to(next_position) * MoveSpeed
			running = true
		else:
			velocity = Vector3(0, 0, 0)
			running = false
		
		move_and_slide()
		
		if running:
			meshAnims.play("walk")
	
func damage(amount):
	
	
	if isAlive:
		health += -amount
	
	if health <= 0:
		
		isAlive = false
		$CollisionShape3D.disabled = true
		damageSound.play()
		
		meshAnims.play("die")
		
		player.playerCoins += 1
		
		await get_tree().create_timer(1).timeout
		
		
		
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
