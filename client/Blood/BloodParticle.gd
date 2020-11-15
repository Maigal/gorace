extends RigidBody2D




func _on_BloodParticle_body_entered(body):
	get_tree().call_group("room", "draw_blood_splatter", position.x , position.y, linear_velocity.x, linear_velocity.y, Color(1.0,0,0,1.0))
	queue_free()
