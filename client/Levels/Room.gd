extends Node2D

var otherPlayer = preload("res://PlayerOther.tscn")

func _ready():
	get_tree().call_group("global", "on_joined_room")

func create_other_players(players_list):
	print('oplayers: ', players_list)
	for i in range(players_list.size()):
		var oPlayerData = players_list[i]
		var instancedScene = otherPlayer.instance()
		instancedScene.name = "OtherPlayer" + str(oPlayerData.id)
		instancedScene.instanceId = oPlayerData.id
		instancedScene.nickname = oPlayerData.nickname
		instancedScene.position.x = oPlayerData.x
		instancedScene.position.y = oPlayerData.y
		if $OtherPlayers.get_node_or_null("OtherPlayer" + str(oPlayerData.id)):
			pass
		else:
			$OtherPlayers.add_child(instancedScene)
			instancedScene.get_other_player_customization_data(oPlayerData.customization)
		
func create_new_player(player):
	print('player: ', player)
	var instancedScene = otherPlayer.instance()
	instancedScene.name = "OtherPlayer" + str(player.id)
	instancedScene.instanceId = player.id
	instancedScene.nickname = player.nickname
	instancedScene.position.x = player.x
	instancedScene.position.y = player.y
	if $OtherPlayers.get_node_or_null("OtherPlayer" + str(player.id)):
			pass
	else:
		$OtherPlayers.add_child(instancedScene)
		instancedScene.get_other_player_customization_data(player.customization)

func update_other_players_positions(players_list):
	for i in range(players_list.size()):
		var oPlayerData = players_list[i]
		var oPlayerInstance = get_node("OtherPlayers/OtherPlayer" + str(oPlayerData.id))
		if oPlayerInstance:
			oPlayerInstance.position.x = oPlayerData.x
			oPlayerInstance.position.y = oPlayerData.y
			oPlayerInstance.scale.x = oPlayerData.dir
			oPlayerInstance.playAnimation(oPlayerData.animation)
			
func player_death(playerData, deathData):
		var oPlayerInstance = get_node("OtherPlayers/OtherPlayer" + str(playerData.id))
		if oPlayerInstance:
			oPlayerInstance.explode(deathData.dirX, deathData.dirY, deathData.distX, deathData.distY, deathData.force)
			
func disconnect_player(player_id):
	get_node("OtherPlayers/OtherPlayer" + str(player_id)).queue_free()
	
func start_room():
	get_tree().call_group("roomUI", "start_countdown")
	
func room_result(result):
	get_tree().call_group("roomUI", "room_result", result)

func open_room():
	print('opening room')
	$RoomStartBlock.queue_free()
	
func quit_room():
	get_tree().call_group("global", "leave_room")
	
func left_room():
	get_tree().change_scene("res://Lobby.tscn")
	
