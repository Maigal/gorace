extends Node

export var websocket_url = "ws://127.0.0.1:3000"

var _client = WebSocketClient.new()

var nickname
var userId
var roomType
var roomCode
var player_customization = {
	body_color = 0,
	body_equip = 0,
	eyes = 0,
	eyes_color = 0
}


#var player_customization_body_color
#var player_customization_eyes

func _ready():
	print('global ready')
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
		
func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	set_process(false)
	
func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
#	var initialData = {
#		"type": "init",
#		"player_name": global_vars.player_name,
#		"colors": {
#			"color_0": CharacterNode.get_surface_material(0).albedo_color.to_html(false),
#			"color_1": CharacterNode.get_surface_material(1).albedo_color.to_html(false),
#			"color_2": CharacterNode.get_surface_material(2).albedo_color.to_html(false),
#			"color_3": CharacterNode.get_surface_material(3).albedo_color.to_html(false),
#			"color_4": CharacterNode.get_surface_material(4).albedo_color.to_html(false)
#		}
#	}
#	_client.get_peer(1).put_packet(JSON.print(initialData).to_utf8())

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var data = _client.get_peer(1).get_packet().get_string_from_utf8()
#	print(data)
	var parsedData = JSON.parse(data).result
	
#	print(parsedData)
	
	match parsedData["type"]:
		"login":
			if parsedData.status == "success":
				nickname = parsedData.nickname
				userId = parsedData.id
				player_customization.body_equip = parsedData.customization.body_equip
				player_customization.body_color = parsedData.customization.body_color
				player_customization.eyes = parsedData.customization.eyes
				player_customization.eyes_color = parsedData.customization.eyes_color
				get_tree().change_scene("res://Lobby.tscn")
			elif parsedData.status == "error":
				get_tree().call_group("login", "get_login_error_message", parsedData.error_message)
		"join_room":
			if parsedData.status == "success":
				roomType = parsedData.roomType
				roomCode = parsedData.roomCode
				get_tree().change_scene(parsedData["roomScene"])
			elif parsedData.status == "error":
				print(parsedData["error_message"])
		"join_queue":
			if parsedData.status == "success":
				get_tree().call_group("lobby", "joined_queue")
#				get_tree().change_scene(parsedData["roomScene"])
		"left_queue":
			if parsedData.status == "success":
				get_tree().call_group("lobby", "left_queue")
		"found_room":
			on_join_room(parsedData.roomType, parsedData.roomCode)
		"left_room":
			get_tree().call_group("room", "left_room")
		"room_start":
			get_tree().call_group("room", "start_room")
		"room_result":
			get_tree().call_group("room", "room_result", parsedData.result)
		"create_other_players":
			get_tree().call_group("room", "create_other_players", parsedData["players"])
		"create_new_player":
			get_tree().call_group("room", "create_new_player", parsedData["player"])
		"update_other_players_positions":
			get_tree().call_group("room", "update_other_players_positions", parsedData["players"])
		"disconnect_player":
			get_tree().call_group("room", "disconnect_player", parsedData["playerId"])
		"player_death":
			get_tree().call_group("room", "player_death", parsedData["player"], parsedData["deathData"])
			
func get_player_data():
	var data = {
		level = 0,
		nickname = nickname,
		body_color = player_customization.body_color,
		body_equip = player_customization.body_equip,
		eyes = player_customization.eyes,
		eyes_color = player_customization.eyes_color
	}
	return data
	
func get_player_customization_data():
	return player_customization
	
func update_customization_data(data):
	if data.has('body_equip'):
		player_customization.body_equip = data.body_equip
	if data.has('body_equips'):
		player_customization.body_equip = data.body_equips
	if data.has('eyes'):
		player_customization.eyes = data.eyes
	if data.has('body_color'):
		player_customization.body_color = data.body_color
	if data.has('body_colors'):
		player_customization.body_color = data.body_colors
	if data.has('eyes_color'):
		player_customization.eyes_color = data.eyes_color
	if data.has('eyes_colors'):
		player_customization.eyes_color = data.eyes_colors
		
	get_tree().call_group('player', 'get_player_customization_data', player_customization)
	var message = {
		type = "update_customization",
		customization = player_customization
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	
func _process(delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
#	var data = {
#		"type": "update_position",
#		"anim": $Player.current_animation,
#		"position": {
#			"x": $Player.translation.x,
#			"y": $Player.translation.y,
#			"z": $Player.translation.z
#		},
#		"rotation": {
#			"x": $Player.rotation_degrees.x,
#			"y": $Player.rotation_degrees.y,
#			"z": $Player.rotation_degrees.z
#		}
#	}
#	_client.get_peer(1).put_packet(JSON.print(data).to_utf8())
	_client.poll()

func on_pressed_login(username, password):
	var message = {
		type = "login",
		username = username,
		password = password
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())

	
func on_join_room(roomType, room):
	var message = {
		type = "join_room",
		roomType = roomType,
		roomCode = room
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	
	
func on_join_queue(roomType):
	var message = {
		type = "join_queue",
		roomType = roomType
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	
func on_leave_queue(roomType):
	var message = {
		type = "leave_queue",
		roomType = roomType
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	
func on_joined_room():
	var data = {
		nickname = nickname,
		body_color = player_customization.body_color,
		body_equip = player_customization.body_equip,
		eyes = player_customization.eyes,
		eyes_color = player_customization.eyes_color
	}
	get_tree().call_group("player", "get_player_customization_data", data)
	
	var message = {
		type = "joined_room",
		roomType = roomType,
		roomCode = roomCode
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	
func leave_room():
	var message = {
		type = "leave_room",
		roomType = roomType,
		roomCode = roomCode
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	
func update_player(playerData):
	var message = playerData
	message.type = "update_position"
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	
func entered_room_goal():
	var message = {
		type = "entered_room_goal",
		roomType = roomType,
		roomCode = roomCode
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	
func on_player_death(dirX, dirY, distX, distY, force):
	var message = {
		type = "player_death",
		dirX = dirX,
		dirY = dirY,
		distX = distX,
		distY = distY,
		force = force
	}
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
