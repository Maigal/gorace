extends Control

func _on_ButtonQuitRoom_pressed():
	$ButtonQuitRoom.hide()
	get_tree().call_group("room", "quit_room")
