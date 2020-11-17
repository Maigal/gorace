extends Node2D

var DeathParticle = load("res://Death/DeathParticle.tscn")
export var DeathParticleNumber = 20
export var RandomVelocity = 800.0



var rng = RandomNumberGenerator.new()

func explode(dir, dist, force):
	var particles_to_spawn = DeathParticleNumber
	
	var spawnedParticle: RigidBody2D
	
	for i in range(particles_to_spawn):
		spawnedParticle = DeathParticle.instance()
		get_tree().root.add_child(spawnedParticle)
		spawnedParticle.global_position = Vector2(rng.randf_range(global_position.x - 20,global_position.x + 20), rng.randf_range(global_position.y - 20,global_position.y + 20))
		spawnedParticle.linear_velocity = Vector2(rng.randf_range((dist.x * force) - 40, (dist.x * force) + 40), rng.randf_range((dist.y * force) - 40, (dist.y * force) + 40))
