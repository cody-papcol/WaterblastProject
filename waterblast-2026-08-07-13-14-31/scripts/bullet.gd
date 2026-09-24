extends RigidBody3D

class_name bullet

@onready var bulletexplosion_prefab = preload("res://prefabs/bullet_explosion.tscn")

var weaponDamage = 0
var spawnedExplosion = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_colliding_bodies():
		
		for x in get_colliding_bodies():
			if x is enemy:
				if not spawnedExplosion:
					x.damage(weaponDamage)
		
		if not spawnedExplosion:
			var bulletexplosion : RigidBody3D = bulletexplosion_prefab.instantiate()
			bulletexplosion.transform = transform
			#look_at(global_position + linear_velocity, Vector3.UP)
			#bulletexplosion.global_rotation = global_rotation
			bulletexplosion.apply_impulse(linear_velocity)
			bulletexplosion.add_collision_exception_with(get_collision_exceptions().get(0))
			get_parent().add_child(bulletexplosion)
			spawnedExplosion = true
		
		queue_free()
			
			
		


func _on_timer_timeout() -> void:
	var bulletexplosion : RigidBody3D = bulletexplosion_prefab.instantiate()
	bulletexplosion.transform = transform
	bulletexplosion.apply_impulse(linear_velocity)
	bulletexplosion.add_collision_exception_with(get_collision_exceptions().get(0))
	get_parent().add_child(bulletexplosion)
	queue_free()
