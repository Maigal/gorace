const WebSocket = require('ws');
const https = require('https')
const express = require('express')
const app = express();
const path = require('path');

const LoginModule = require('./Server/Events/Login');
const RoomModule = require('./Server/Events/Room');
const state = require('./Server/state');
const { onlinePlayers } = require('./Server/state');
 
const PORT =  process.env.PORT || 3000
const INDEX = '/client/index.html';


let connectionId = 0
let connectedPlayers = []

const server = express()
  .use(express.static(path.join(__dirname, './client')))
  .listen(PORT, () => console.log(`Listening on ${PORT}`));


const wss = new WebSocket.Server({ server })

wss.on('connection', function connection(ws) {


  ws.connectionId = connectionId
  connectionId

  //console.log('ws', ws._socket)

  var socketAddr = ws._socket.remoteAddress
  console.log('Connection from ' + socketAddr + " - " + new Date())

  connectedPlayers.push({
    connectionId: ws.connectionId
  })

  ws.send(JSON.stringify({
    type: "get_connectionId",
    connectionId: ws.connectionId
  }))



  ws.on('message', function incoming(message) {
    let msg = JSON.parse(message.toString())

    switch (msg.type) {
      case "login":
        const loginResult = LoginModule.login(ws, msg.username, msg.password)
        ws.playerId = loginResult.id
        ws.send(JSON.stringify({type: "login", ...loginResult}))
        break;

      case "join_room":
        const joinRoomResult = RoomModule.join(ws, msg.roomType, msg.roomCode)
        ws.send(JSON.stringify({type: "join_room", ...joinRoomResult}))
        break;

      case "join_queue":
        const joinQueueResult = RoomModule.join(ws, msg.roomType, msg.roomCode)
        ws.send(JSON.stringify({type: "join_queue", ...joinQueueResult}))
        break;

      case "leave_queue":
        const leaveQueueResult = RoomModule.leave(ws, msg.roomType, msg.roomCode)
        ws.send(JSON.stringify({type: "left_queue", ...leaveQueueResult}))
        break;

      case "joined_room":
        const joinedRoomData = RoomModule.joined(ws, msg.roomType, msg.roomCode)
        //console.log('joinr', joinedRoomData)
        if (joinedRoomData.status === "success") {
          setTimeout(() => ws.send(JSON.stringify({type: "create_other_players", players: joinedRoomData.otherPlayers.map(op => op.baseDataParsedForClient())})), 100)
          
          //console.log('iothers', joinedRoomData)
          joinedRoomData.otherPlayers.forEach(otherPlayer => {
            otherPlayer.ws.send(JSON.stringify({type: "create_new_player", player: joinedRoomData.player.baseDataParsedForClient()}))
          })

        }
        break;

      case "leave_room":
        const leaveRoomData = RoomModule.leave(ws, msg.roomType, msg.roomCode)
        ws.send(JSON.stringify({type: "left_room", ...leaveRoomData}))
        break;

      case "entered_room_goal":
        const finishRoomData = RoomModule.enterGoal(ws, msg.roomType, msg.roomCode)
        break;

      case "update_customization":
        console.log('cus msg', msg)
        const playerIndex = onlinePlayers.findIndex(player => player.id === ws.playerId)

        if (playerIndex >= 0 && playerIndex.customization) {
          onlinePlayers[playerIndex].customization = msg.customization
        }
        break;

      case "update_position":
        const updatedPositionData = RoomModule.updatePosition(ws, msg.x, msg.y, msg.animation, msg.dir)
        break;

      case "player_death":
        //console.log('player died')
        const playerDeathData = RoomModule.playerDeath(ws, msg.dirX, msg.dirY, msg.distX, msg.distY, msg.force)
        if (playerDeathData.status === "success") {
          playerDeathData.otherPlayers.forEach(otherPlayer => {
            otherPlayer.ws.send(JSON.stringify({type: "player_death", player: playerDeathData.player.parseForClient(), deathData: playerDeathData.deathData}))
          })
        }

      default:
        break;
    }

    // let player = connectedPlayers.find(player => player.uid == ws.uid)

  })

  ws.on('close', function close() {
    console.log('Disconnected: ', ws.connectionId);
    const player = state.onlinePlayers.find(player => player.id === ws.playerId)
    

    if (player && player.roomType && player.roomCode) {
      state.rooms[player.roomType][player.roomCode].players.forEach(pl => {
        if (pl.ws.readyState) {
          pl.ws.send(JSON.stringify({
            type: "disconnect_player",
            playerId: player.ws.playerId
          }));
        }
        
      });
  
      state.rooms[player.roomType][player.roomCode].removePlayer(player.id)
      
    } else if (state.matchmaking.versus.find(player => player.id === ws.playerId)){
      state.matchmaking.versus = state.matchmaking.versus.filter(player => player.id !== ws.playerId)
    }

    state.disconnectPlayer(ws.playerId)
    
  });
})


setInterval(RoomModule.emitUpdate, 1000/30)