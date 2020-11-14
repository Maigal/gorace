extends Node2D

var otherPlayer = preload("res://PlayerOther.tscn")

func _ready():
	get_tree().call_group("global", "joined_room")

func create_other_players(players_list):
	print('entrando')
	for i in range(players_list.size()):
		var oPlayerData = players_list[i]
		var instancedScene = otherPlayer.instance()
		instancedScene.name = "OtherPlayer" + str(oPlayerData.id)
		instancedScene.instanceId = oPlayerData.id
		instancedScene.nickname = oPlayerData.nickname
		instancedScene.position.x = oPlayerData.x
		instancedScene.position.y = oPlayerData.y
		$OtherPlayers.add_child(instancedScene)
		
func create_new_player(player):
	var instancedScene = otherPlayer.instance()
	instancedScene.name = "OtherPlayer" + str(player.id)
	instancedScene.instanceId = player.id
	instancedScene.nickname = player.nickname
	instancedScene.position.x = player.x
	instancedScene.position.y = player.y
	$OtherPlayers.add_child(instancedScene)
