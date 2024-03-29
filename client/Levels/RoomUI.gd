extends CanvasLayer

func _on_ButtonQuitRoom_pressed():
	$ButtonQuitRoom.hide()
	exit_room()
	
func room_result(result):
	if result == "victory":
		$ResultWrapper/ResultAnimation.play("ResultWin")
	else:
		get_tree().call_group("player", "on_hit_trap", 20, Vector2(0,0))
		$ResultWrapper/ResultAnimation.play("ResultLose")
		
func start_countdown():
	print('starting countdown')
	$CountdownGroup/CountdownWrapper/CountdownAnimation.play("Countdown")
	
func finish_countdown():
	get_tree().call_group("room", "open_room")

func exit_room():
	get_tree().call_group("room", "quit_room")
