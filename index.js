const WebSocket = require('ws');
const https = require('https')
const express = require('express')
const app = express();
const path = require('path');

const LoginModule = require('./Server/Events/Login');
const RoomModule = require('./Server/Events/Room');
 
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
        

      default:
        break;
    }

    // let player = connectedPlayers.find(player => player.uid == ws.uid)

  })

  ws.on('close', function close() {
    console.log('Disconnected: ', ws.connectionId);
    // connectedPlayers = connectedPlayers.filter(player => player.uid !== ws.uid)
    // console.log('remaining playhers:', connectedPlayers)
    // wss.clients.forEach(function each(client) {
    //   if (client !== ws && client.readyState === WebSocket.OPEN) {
    //     client.send(JSON.stringify({
    //       type: "disconnect_player",
    //       player_id: ws.uid
    //     }));
    //   }
    // });
  });
})
