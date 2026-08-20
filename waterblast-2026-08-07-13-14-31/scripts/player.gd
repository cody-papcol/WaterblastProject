extends CharacterBody3D

# prefabs
@onready var bullet_prefab = preload("res://prefabs/bullet.tscn")

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 10.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003

# weapon vars
var bullet_velocity = 20.0
@export var max_ammo = 25
@onready var ammo = 0
var bulletDamage = 0
@export var firerate = 0.05



# individual weapon variables
# pistol
var pistolBulletVelocity = 20.0
var pistolDamage = 30.0
var pistolMaxAmmo = 20
var pistolFireRate = 0.15
var pistolLevel = 0

# rifle
var rifleBulletVelocity = 35.0
var rifleDamage = 40
var rifleMaxAmmo = 30
var rifleFireRate = 0.1
var rifleLevel = 0

# shotgun
var shotgunBulletVelocity = 20.0
var shotgunDamage = 20
var shotgunMaxAmmo = 15
var shotgunFireRate = 0.5
@export var shotgunSpread = 0.15
@export var shotgunPellets = 5
var shotgunLevel = 0

# washer
var washerBulletVelocity = 50.0
var washerDamage = 20.0
var washerMaxAmmo = 100
var washerFireRate = 0.02
@export var washerSpread = 0.5
var washerLevel = 0

# vars
var sprinting = false
var moving = false
var reloading = false
var health = 100
var walking_wait_time = 0.6
var sprinting_wait_time = 0.3
var playerCoins = 0
var in_shop = false

var can_shoot = true
var current_interactable = null


# weapon number:
# 0 = pistol, 1 = rifle, 2 = shotgun, 3 = pressure washer
@export var weapon = 0

#camera bob vars
const BOB_FREQ = 2.0
const BOB_AMP = 0.05
var t_bob = 0.0

# FOV variables
@export var fov = 80.0
const FOV_CHANGE = 1.5

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var gun = $Head/Camera3D/blockbench_export
@onready var shootTimer = $ShootTimer
@onready var raycast = $Head/Camera3D/InteractionRay
@onready var HealthComponent = $HealthComponent
@onready var muzzle = $Head/Camera3D/blockbench_export/Muzzle
@onready var CoinLabel = $HUD/Control/CoinLabel
@onready var blocking = $Head/Camera3D/blockbench_export/Muzzle/Blocking

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	$Head/Camera3D/blockbench_export/RifleTriggerArm.visible = false
	$Head/Camera3D/blockbench_export/RifleStableArm.visible = false
	$Head/Camera3D/blockbench_export/ShotgunMesh.visible = false
	$Head/Camera3D/blockbench_export/PistolArm.visible = false
	$Head/Camera3D/blockbench_export/PistolMesh.visible = false
	$Head/Camera3D/blockbench_export/RifleMesh.visible = false
	$Head/Camera3D/blockbench_export/WasherMesh1.visible = false
	
	if weapon == 0:
		firerate = pistolFireRate
		max_ammo = pistolMaxAmmo
		bulletDamage = pistolDamage
		bullet_velocity = pistolBulletVelocity
		
		# visibility of models
		$Head/Camera3D/blockbench_export/PistolArm.visible = true
		$Head/Camera3D/blockbench_export/PistolMesh.visible = true
		
	# Rifle
	if weapon == 1:
		firerate = rifleFireRate
		max_ammo = rifleMaxAmmo
		bulletDamage = rifleDamage
		bullet_velocity = rifleBulletVelocity
		
		$Head/Camera3D/blockbench_export/RifleTriggerArm.visible = true
		$Head/Camera3D/blockbench_export/RifleStableArm.visible = true
		$Head/Camera3D/blockbench_export/RifleMesh.visible = true
		
	# Shotgun
	if weapon == 2:
		firerate = shotgunFireRate
		max_ammo = shotgunMaxAmmo
		bulletDamage = shotgunDamage
		bullet_velocity = shotgunBulletVelocity
		$Head/Camera3D/blockbench_export/RifleTriggerArm.visible = true
		$Head/Camera3D/blockbench_export/RifleStableArm.visible = true
		$Head/Camera3D/blockbench_export/ShotgunMesh.visible = true
		
	# Pressure Washer
	if weapon == 3:
		firerate = washerFireRate
		max_ammo = washerMaxAmmo
		bulletDamage = washerDamage
		bullet_velocity = washerBulletVelocity
		$Head/Camera3D/blockbench_export/RifleTriggerArm.visible = true
		$Head/Camera3D/blockbench_export/RifleStableArm.visible = true
		$Head/Camera3D/blockbench_export/WasherMesh1.visible = true
	
	
	
	shootTimer.wait_time = firerate
	ammo = max_ammo

func change_weapon(num):
	
	$Head/Camera3D/blockbench_export/RifleTriggerArm.visible = false
	$Head/Camera3D/blockbench_export/RifleStableArm.visible = false
	$Head/Camera3D/blockbench_export/ShotgunMesh.visible = false
	$Head/Camera3D/blockbench_export/PistolArm.visible = false
	$Head/Camera3D/blockbench_export/PistolMesh.visible = false
	$Head/Camera3D/blockbench_export/RifleMesh.visible = false
	$Head/Camera3D/blockbench_export/WasherMesh1.visible = false
	
	# Pistol
	if num == 0:
		firerate = pistolFireRate
		max_ammo = pistolMaxAmmo
		bulletDamage = pistolDamage
		bullet_velocity = pistolBulletVelocity
		weapon = 0
		
		# visibility of models
		$Head/Camera3D/blockbench_export/PistolArm.visible = true
		$Head/Camera3D/blockbench_export/PistolMesh.visible = true
		
	# Rifle
	if num == 1:
		firerate = rifleFireRate
		max_ammo = rifleMaxAmmo
		bulletDamage = rifleDamage
		bullet_velocity = rifleBulletVelocity
		weapon = 1
		
		$Head/Camera3D/blockbench_export/RifleTriggerArm.visible = true
		$Head/Camera3D/blockbench_export/RifleStableArm.visible = true
		$Head/Camera3D/blockbench_export/RifleMesh.visible = true
		
	# Shotgun
	if num == 2:
		firerate = shotgunFireRate
		max_ammo = shotgunMaxAmmo
		bulletDamage = shotgunDamage
		bullet_velocity = shotgunBulletVelocity
		weapon = 2
		
		$Head/Camera3D/blockbench_export/RifleTriggerArm.visible = true
		$Head/Camera3D/blockbench_export/RifleStableArm.visible = true
		$Head/Camera3D/blockbench_export/ShotgunMesh.visible = true
		
	# Pressure Washer
	if num == 3:
		firerate = washerFireRate
		max_ammo = washerMaxAmmo
		bulletDamage = washerDamage
		bullet_velocity = washerBulletVelocity
		weapon = 3
		
		$Head/Camera3D/blockbench_export/RifleTriggerArm.visible = true
		$Head/Camera3D/blockbench_export/RifleStableArm.visible = true
		$Head/Camera3D/blockbench_export/WasherMesh1.visible = true
	
	
	
	shootTimer.wait_time = firerate
	ammo = max_ammo

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-85), deg_to_rad(85))
		
	# escape button to menu
	if Input.is_action_just_pressed("escape"):
		if in_shop:
			close_shop()
			in_shop = false
		else:
			get_tree().change_scene_to_file("res://levels/main_menu.tscn")
	
		
	# initial footstep sounds
	if Input.is_action_just_pressed("forward") or Input.is_action_just_pressed("back") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		if $FootstepTimer.is_stopped():
			$FootstepTimer.start()
	
	# sprint animation
	if Input.is_action_just_pressed("sprint") and reloading == false:
		$AnimationPlayer.play("sprint")
		sprinting = true
		$FootstepTimer.wait_time = sprinting_wait_time
		
	if Input.is_action_just_pressed("interact"):
		activate()
	
	#handling reload
	if Input.is_action_just_pressed("reload") and ammo != max_ammo:
		reloading = true
		sprinting = false
		$AnimationPlayer.play("reload")
		$ReloadTimer.start()
	
	
	# handling weapon select
	if Input.is_action_just_pressed("WeaponSlot1"):
		change_weapon(0)
	if Input.is_action_just_pressed("WeaponSlot2"):
		change_weapon(1)
	if Input.is_action_just_pressed("WeaponSlot3"):
		change_weapon(2)
	if Input.is_action_just_pressed("WeaponSlot4"):
		change_weapon(3)
	
	
func _physics_process(delta: float) -> void:
	
	#infinite health test
	_damage(-20)
	
	# shooting mechanics, USE JUST PRESSED NOT PRESSED
	if Input.is_action_pressed("shoot") and reloading == false and sprinting == false:
		
		# checking with delay
		if can_shoot:
			
			if !blocking.is_colliding():
				
				# dealing with ammo
				if ammo > 0:
					
					ammo += -1
					
					if weapon == 2:
						
						#shotgun bullet spawns
						for x in shotgunPellets:
							var new_bullet : RigidBody3D = bullet_prefab.instantiate()
							new_bullet.global_transform = muzzle.global_transform
							var shotgunDirection = muzzle.global_transform.basis.z

							shotgunDirection += muzzle.global_transform.basis.x * randf_range(-shotgunSpread, shotgunSpread)
							shotgunDirection += muzzle.global_transform.basis.y * randf_range(-shotgunSpread, shotgunSpread)
							shotgunDirection = shotgunDirection.normalized()

							new_bullet.apply_impulse(shotgunDirection * bullet_velocity)
							
							new_bullet.add_collision_exception_with($".")
							new_bullet.add_collision_exception_with(new_bullet)
							new_bullet.weaponDamage = bulletDamage
							get_parent().add_child(new_bullet)
					
					
					# creating bullet for Washer
					elif weapon == 3:
						var new_bullet : RigidBody3D = bullet_prefab.instantiate()
						new_bullet.global_transform = $Head/Camera3D/blockbench_export/Muzzle.global_transform
						
						# randomize direction
						var washerDirection = muzzle.global_transform.basis.z
						washerDirection += muzzle.global_transform.basis.x * randf_range(-washerSpread, washerSpread)
						washerDirection += muzzle.global_transform.basis.y * randf_range(-washerSpread, washerSpread)
						washerDirection = washerDirection.normalized()
						
						new_bullet.apply_impulse(washerDirection * bullet_velocity)
						new_bullet.add_collision_exception_with($".")
						new_bullet.add_collision_exception_with(new_bullet)
						new_bullet.weaponDamage = bulletDamage
						get_parent().add_child(new_bullet)
					
					# other bullets
					else:
						var new_bullet : RigidBody3D = bullet_prefab.instantiate()
						new_bullet.global_transform = $Head/Camera3D/blockbench_export/Muzzle.global_transform
						new_bullet.apply_impulse($Head/Camera3D/blockbench_export/Muzzle.global_transform.basis.z * bullet_velocity)
						new_bullet.add_collision_exception_with($".")
						new_bullet.add_collision_exception_with(new_bullet)
						new_bullet.weaponDamage = bulletDamage
						get_parent().add_child(new_bullet)
					
					print(bullet_velocity)
					
					#starting firerate timer
					can_shoot = false
					shootTimer.start()
					
					# shoot sound
					$SpraySound.play()
					
					if ammo == 0:
						reloading = true
						$AnimationPlayer.play("reload")
						$ReloadTimer.start()
					
				elif reloading == false:
					# reload
					reloading = true
					$AnimationPlayer.play("reload")
					$ReloadTimer.start()
			
	
	#check for interaction collisions
	check_hover_collision()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		await_landing()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$FootstepSound.play()
	
	# Handle sprint
	if Input.is_action_pressed("sprint") and reloading == false:
		speed = SPRINT_SPEED
		
	elif reloading == false:
		speed = WALK_SPEED
		if Input.is_action_just_released("sprint"):
			$AnimationPlayer.play_backwards("sprint")
		sprinting = false
		$FootstepTimer.wait_time = walking_wait_time
		
	else:
		speed = WALK_SPEED
		sprinting = false
		$FootstepTimer.wait_time = walking_wait_time
			
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction: Vector3 = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			moving = true
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			moving = false
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 12.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 12.0)
			
	else:
		moving = false
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
		
	# head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	gun.transform.origin = _headbob(-t_bob) - Vector3(-0.3, 0.7, 0.4)
	
	# fov
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = fov + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()
	
	CoinLabel.text = str(playerCoins) + " Coins"

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

# reload timer end
func _on_reload_timer_timeout() -> void:
	reloading = false
	ammo = max_ammo
	if Input.is_action_pressed("sprint"):
		sprinting = true
		$FootstepTimer.wait_time = sprinting_wait_time
		$AnimationPlayer.play("sprint")
		

func _damage(value):
	if value >= 0:
		health -= value
		$HealthComponent.health = health
		$DamageSound.play()
		if health < 50:
			$HUD/Control/TextureRect.modulate = Color(1, 0, 0, 1 - $HealthComponent.health/50)
	elif health < 100:
		if health - value >= 100:
			health = 100
			$HealthComponent.health = health
			$HUD/Control/TextureRect.modulate = Color(1, 0, 0, 1 - $HealthComponent.health/100)
		else:
			health -= value
			$HealthComponent.health = health
			if health < 50:
				$HUD/Control/TextureRect.modulate = Color(1, 0, 0, 1 - $HealthComponent.health/50)
			else:
				$HUD/Control/TextureRect.modulate = Color(1, 0, 0, 0)

func _on_footstep_timer_timeout() -> void:
	if moving:
		$FootstepSound.play()

func await_landing():

	
	while !is_on_floor():
		await get_tree().physics_frame
		if !is_inside_tree():
			break
			
	if is_inside_tree():
		$LandingSound.play()
	
	
	


func _on_shoot_timer_timeout() -> void:
	can_shoot = true

func check_hover_collision():
	if raycast.is_colliding():
		var hover_collider = raycast.get_collider()
		if hover_collider and is_instance_valid(hover_collider) and hover_collider.has_method("interact") and hover_collider.has_method("show_prompt"):
			if current_interactable != hover_collider:
				if current_interactable:
					current_interactable.hide_prompt()
				current_interactable = hover_collider
				current_interactable.show_prompt()
		else:
			hide_current_prompt()
	else:
		hide_current_prompt()

func hide_current_prompt():
	if current_interactable:
		current_interactable.hide_prompt()
		current_interactable = null

func activate():
	var hit = raycast.get_collider()
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if hit and hit.has_method("interact"):
			hit.interact()

func on_damage(attack):
	health = $HealthComponent.health
	_damage(0)
	#overlay_fade()

# shop logic
func open_shop():
	$Shop.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	in_shop = true
	
func close_shop():
	$Shop.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Pistol Upgrades

func upgrade_pistol():
	if pistolLevel < 4:
		
		if pistolLevel == 0:
			pistolFireRate = 0.1
			firerate = pistolFireRate
			
		if pistolLevel == 1:
			pistolBulletVelocity = 40.0
			bullet_velocity = pistolBulletVelocity
			
		if pistolLevel == 2:
			pistolMaxAmmo = 35
			max_ammo = pistolMaxAmmo
			
		if pistolLevel == 3:
			pistolDamage = 40
			bulletDamage = pistolDamage
			
		pistolLevel += 1
		change_weapon(0)

func upgrade_rifle():
	if rifleLevel < 4:
		
		if rifleLevel == 0:
			rifleFireRate = 0.07
			firerate = rifleFireRate
			
		if rifleLevel == 1:
			rifleBulletVelocity = 50.0
			
		if rifleLevel == 2:
			rifleMaxAmmo = 75
			max_ammo = rifleMaxAmmo
			
		if rifleLevel == 3:
			rifleDamage = 50
			bulletDamage = rifleDamage
			
		rifleLevel += 1
		change_weapon(1)
		
func upgrade_shotgun():
	if shotgunLevel < 4:
		
		if shotgunLevel == 0:
			shotgunFireRate = 0.3
			firerate = shotgunFireRate
			
		if shotgunLevel == 1:
			shotgunBulletVelocity = 35.0
			
		if shotgunLevel == 2:
			shotgunMaxAmmo = 40
			max_ammo = shotgunMaxAmmo
			
		if shotgunLevel == 3:
			shotgunPellets = 8
			
		shotgunLevel += 1
		change_weapon(2)

func upgrade_washer():
	if washerLevel < 4:
		
		if washerLevel == 0:
			washerFireRate = 0.01
			firerate = washerFireRate
			
		if washerLevel == 1:
			washerBulletVelocity = 80.0
			
		if washerLevel == 2:
			washerMaxAmmo = 200
			max_ammo = washerMaxAmmo
			
		if washerLevel == 3:
			washerSpread = 1
			
		shotgunLevel += 1
		change_weapon(3)

func on_death() -> void:
	get_tree().change_scene_to_file("res://levels/death_menu.tscn")
