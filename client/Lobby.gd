extends Node2D

var playerData
var isInQueue = false

func _ready():
	$Player.isInLobby = true
	$Player/PlayerCamera.queue_free()
	$MatchmakingText.hide()
	$ButtonCancelQueue.hide()
	
	for node in get_tree().get_nodes_in_group("global"):
		var result = node.call("get_player_data")
		playerData = result
		
	get_tree().call_group("player", "get_player_customization_data", playerData)	
	


func _on_ButtonOpenWorld_pressed():
	get_tree().call_group("global", "on_join_room", "openWorld", "AAAA")


func _on_ButtonMatchmaking_pressed():
	get_tree().call_group("global", "on_join_queue", "versus")
	
func _on_ButtonCancelQueue_pressed():
	get_tree().call_group("global", "on_leave_queue", "versus")

func joined_queue():
	$ButtonMatchmaking.hide()
	$ButtonOpenWorld.hide()
	$ButtonCancelQueue.show()
	$MatchmakingText.show()

func left_queue():
	$ButtonMatchmaking.show()
	$ButtonOpenWorld.show()
	$MatchmakingText.hide()
	$ButtonCancelQueue.hide()

