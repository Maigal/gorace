extends Node2D

var BloodParticle = load("res://Death/DeathParticle.tscn")
export var BloodParticleNumber = 10
export var RandomVelocity = 800.0



var rnd = RandomNumberGenerator.new()

func explode(particles_to_spawn = -1):
	print('SPLATTER')
	if (particles_to_spawn <= 0):
		particles_to_spawn = BloodParticleNumber
		
		var spawnedParticle: RigidBody2D
		
		for i in range(particles_to_spawn):
			spawnedParticle = BloodParticle.instance()
			get_tree().root.add_child(spawnedParticle)
			spawnedParticle.global_position = global_position
			spawnedParticle.linear_velocity = Vector2(rnd.randf_range(800, 600), rnd.randf_range(-100, 100))
