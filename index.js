const WebSocket = require('ws');
const https = require('https')
const express = require('express')
const app = express();
const path = require('path');
 
const PORT =  process.env.PORT || 3000
const INDEX = '/client/index.html';


let idCounter = 0
let connectedPlayers = []

const server = express()
  .use(express.static(path.join(__dirname, './client')))
  .listen(PORT, () => console.log(`Listening on ${PORT}`));


const wss = new WebSocket.Server({ server })

wss.on('connection', function connection(ws) {


  ws.uid = idCounter
  idCounter++

  //console.log('ws', ws._socket)

  var socketAddr = ws._socket.remoteAddress
  console.log('Connection from ' + socketAddr + " - " + new Date())

  connectedPlayers.push({
    uid: ws.uid
  })

  ws.send(JSON.stringify({
    type: "get_uid",
    uid: ws.uid
  }))

  ws.on('close', function close() {
    console.log('Disconnected: ', ws.uid);
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

  ws.on('message', function incoming(message) {
    let msg = JSON.parse(message.toString())

    console.log('message from client: ', + msg)

    // let player = connectedPlayers.find(player => player.uid == ws.uid)

  //   switch (msg.type) {
  //     case "init":
  //       player.colors = msg.colors
  //       player.position = {x:0, y:0, z:0}
  //       player.rotation = {x:0, y:0, z:0}
  //       player.anim = "Idle"
  //       player.player_name = msg.player_name
  //       console.log('cp', connectedPlayers)
  //       ws.send(JSON.stringify({
  //         type: "create_other_players",
  //         players: connectedPlayers.filter(player => player.uid !== ws.uid)
  //       }))

  //       wss.clients.forEach(function each(client) {
  //         if (client !== ws && client.readyState === WebSocket.OPEN) {
  //           client.send(JSON.stringify({
  //             type: "create_new_player",
  //             player: connectedPlayers.find(player => player.uid == ws.uid)
  //           }));
  //         }
  //       });
  //       break;

  //     case "update_position":
  //       player.position = msg.position
  //       player.rotation = msg.rotation
  //       player.anim = msg.anim
  //       break;

  //     default:
  //       break;
  //   }
  })

  
})
