extends RigidBody2D

func _on_BloodParticle_body_entered(body):
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
