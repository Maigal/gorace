const WebSocket = require('ws');
const https = require('https')
const express = require('express')
const app = express();
const path = require('path');

const LoginModule = require('./Server/Events/Login');
const RoomModule = require('./Server/Events/Room');
const state = require('./Server/state')
 
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

      case "joined_room":
        const joinedRoomData = RoomModule.joined(ws, msg.roomType, msg.roomCode)
        if (joinedRoomData.status === "success") {
          setTimeout(() => ws.send(JSON.stringify({type: "create_other_players", players: joinedRoomData.otherPlayers.map(op => op.parseForClient())})), 100)
          
          //console.log('iothers', joinedRoomData)
          joinedRoomData.otherPlayers.forEach(otherPlayer => {
            otherPlayer.ws.send(JSON.stringify({type: "create_new_player", player: joinedRoomData.player.parseForClient()}))
          })

        }
      
      case "update_position":
        const updatedPositionData = RoomModule.updatePosition(ws, msg.x, msg.y, msg.animation, msg.dir)

      default:
        break;
    }

    // let player = connectedPlayers.find(player => player.uid == ws.uid)

  })

  ws.on('close', function close() {
    console.log('Disconnected: ', ws.connectionId);
    const player = state.onlinePlayers.find(player => player.id === ws.playerId)
    
    

    console.log('remaining playhers:', state.onlinePlayers)

    if (player) {
      state.rooms[player.roomType][player.roomCode].players.forEach(pl => {
        console.log('CL', player.ws.readyState)
        if (pl.ws.readyState) {
          pl.ws.send(JSON.stringify({
            type: "disconnect_player",
            playerId: player.ws.playerId
          }));
        }
      });
  
      state.rooms[player.roomType][player.roomCode].players = state.rooms[player.roomType][player.roomCode].players.filter(player => player.id !== ws.playerId)
      state.onlinePlayers = state.onlinePlayers.filter(player => player.id !== ws.playerId)
    }
    
  });
})


setInterval(RoomModule.emitUpdate, 1000/30)