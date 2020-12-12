extends Area2D



func _on_RoomGoal_body_entered(body):
	print('GANADOR')
	get_tree().call_group("room", "entered_goal")
