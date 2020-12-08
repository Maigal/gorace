extends Node2D

var playerData

func _ready():
	$Player.isInLobby = true
	$Player/PlayerCamera.queue_free()
	
	for node in get_tree().get_nodes_in_group("global"):
		var result = node.call("get_player_data")
		playerData = result
		
	get_tree().call_group("player", "get_player_customization_data", playerData)	
	


func _on_Button_pressed():
	get_tree().call_group("global", "on_join_room", "openWorld", "AAAA")


func _on_ButtonMatchmaking_pressed():
	print('toque el boton papa')
	get_tree().call_group("global", "on_join_room", "versus", false)
