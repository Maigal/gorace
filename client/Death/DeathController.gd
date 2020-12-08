extends Node2D

var DeathParticle = load("res://Death/DeathParticle.tscn")
export var DeathParticleNumber = 20



var rng = RandomNumberGenerator.new()

func explode(dir, dist, force, colors):
	print('cols: ', colors)
	var particles_to_spawn = DeathParticleNumber
	
	var spawnedParticle: RigidBody2D
	
	for i in range(particles_to_spawn):
		spawnedParticle = DeathParticle.instance()
		spawnedParticle.color = colors
		get_tree().root.add_child(spawnedParticle)
		spawnedParticle.global_position = Vector2(rng.randf_range(global_position.x - 30,global_position.x + 30), rng.randf_range(global_position.y - 30,global_position.y + 30))
		spawnedParticle.linear_velocity = Vector2(rng.randf_range((dist.x * force) - 50, (dist.x * force) + 50), rng.randf_range((dist.y * force) - 50, (dist.y * force) + 50))
