extends Node2D

func _ready():
	$Player.isInLobby = true
	$Player/PlayerCamera.queue_free()


func _on_Button_pressed():
	get_tree().call_group("global", "on_join_room", "openWorld", "AAAA")
