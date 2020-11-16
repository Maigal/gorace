extends RigidBody2D

var prevX = position.x
var prevY = position.y
var dir = Vector2.ZERO


func _physics_process(delta):
	if position.x > prevX:
		dir.x = 1
	elif position.x < prevX:
		dir.x = -1
	else:
		dir.x = 0
		
	if position.y > prevY:
		dir.y = 1
	elif position.y < prevY:
		dir.y = -1
	else:
		dir.y = 0
		
	prevX = position.x
	prevY = position.y

func _on_BloodParticle_body_entered(body):
	get_tree().call_group("room", "draw_blood_splatter", position, linear_velocity, dir, Color(1.0,0,0,1.0))
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
