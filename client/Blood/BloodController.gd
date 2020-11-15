extends Node2D

var BloodParticle = load("res://Blood/BloodParticle.tscn")
export var BloodParticleNumber = 1
export var RandomVelocity = 800.0



var rnd = RandomNumberGenerator.new()

func splatter(particles_to_spawn = -1):
	print('SPLATTER')
	if (particles_to_spawn <= 0):
		particles_to_spawn = BloodParticleNumber
		
		var spawnedParticle: RigidBody2D
		
		for i in range(particles_to_spawn):
			spawnedParticle = BloodParticle.instance()
			get_tree().root.add_child(spawnedParticle)
			spawnedParticle.global_position = global_position
			spawnedParticle.linear_velocity = Vector2(rnd.randf_range(-RandomVelocity, RandomVelocity), rnd.randf_range(-20, 20))
