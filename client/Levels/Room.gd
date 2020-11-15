extends Node2D

var otherPlayer = preload("res://PlayerOther.tscn")
var bloodTexture = ImageTexture.new()
var bloodData = Image.new()
var rng = RandomNumberGenerator.new()

func _ready():
	get_tree().call_group("global", "joined_room")
	bloodData.create(1800,900, false, Image.FORMAT_RGBA8) # Different formats will have more colors but be slower
	bloodData.fill(Color(0,0,0,0))
	bloodTexture.create_from_image(bloodData)
	bloodTexture.resource_name = "BloodTexture"

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

func update_other_players_positions(players_list):
	for i in range(players_list.size()):
		var oPlayerData = players_list[i]
		var oPlayerInstance = get_node("OtherPlayers/OtherPlayer" + str(oPlayerData.id))
		if oPlayerInstance:
			oPlayerInstance.position.x = oPlayerData.x
			oPlayerInstance.position.y = oPlayerData.y
			oPlayerInstance.scale.x = oPlayerData.dir
			oPlayerInstance.playAnimation(oPlayerData.animation)
			
func disconnect_player(player_id):
	get_node("OtherPlayers/OtherPlayer" + str(player_id)).queue_free()
func draw_blood_splatter(x,y, xvelo, yvelo, col):
	print(xvelo, yvelo)
	bloodData.lock() #Image must be locked when you want to write to it
	for ix in range(-5, 5):
		for iy in range(-5, 5):
			if abs(ix) != abs(iy) || (abs(ix) < 3 && abs(iy) < 3):
				bloodData.set_pixel(x+ix, y+iy, Color(col.r, col.g, col.b, rng.randf_range(0, 1)))
	bloodData.set_pixel(x, y, col)
	bloodData.unlock() #Drawing done, so unlock
	update_blood_texture()
	
func update_blood_texture():
	bloodTexture.set_data(bloodData) # set_data() and create_from_image() seem to do the same thing and have the same performance.
	$BloodSprite.texture = bloodTexture
