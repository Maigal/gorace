extends CanvasLayer

func _on_ButtonQuitRoom_pressed():
	$ButtonQuitRoom.hide()
	exit_room()
	
func room_result(result):
	if result == "victory":
		$ResultWrapper/ResultAnimation.play("ResultWin")
	else:
		$ResultWrapper/ResultAnimation.play("ResultLose")

func exit_room():
	get_tree().call_group("room", "quit_room")
