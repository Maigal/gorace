extends Trap

export var rotation_speed = 10

func _process(delta):
	rotation_degrees += rotation_speed


func _on_Player_entered(body):
	on_player_collision()
