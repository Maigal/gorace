extends Area2D



func _on_RoomGoal_body_entered(body):
	get_tree().call_group("global", "entered_room_goal")
