const db = require('../db.js')
let state = require('../state.js')

module.exports = {

  join(ws, roomType, roomCode) {
    let player = state.onlinePlayers.find(u => u.id === ws.playerId)
    let playerIndex = state.onlinePlayers.findIndex(u => u.id === ws.playerId)
    
    if (roomType === "openWorld") {
      let targetRoom = state.rooms[roomType][roomCode]
      if (targetRoom) {
        state.onlinePlayers[playerIndex].roomType = roomType
        state.onlinePlayers[playerIndex].roomCode = roomCode
        
        targetRoom.players.push(player)
        return {
          status: "success",
          roomType,
          roomCode,
          roomScene: state.rooms.openWorld[roomCode].scene
        }
      } else {
        return {
          status: "error",
          error_message: "Room does not exist"
        }
      }
    }
  },

  joined(ws, roomType, roomCode) {
    //console.log("ws, roomType, roomCode ", ws, roomType, roomCode);
    let user = state.onlinePlayers.find(u => u.id === ws.playerId)
    if (roomType === "openWorld") {
      let targetRoom = state.rooms.openWorld[roomCode]
      // console.log("targetRoom.players", targetRoom.players, user);
      // console.log("targetRoom ", targetRoom);
      if (targetRoom && targetRoom.players.find(player => player.id == user.id)) {
        console.log('state on', state.onlinePlayers)
        return {
          status: "success",
          otherPlayers: targetRoom.players.filter(player => player.id !== user.id),
          player: targetRoom.players.find(player => player.id == ws.playerId)
        }
      } else {
        return {
          status: "error",
          error_message: "Player not in room?"
        }
      }
    }
  },

  updatePosition(ws, x, y, animation, dir) {
   // console.log("ws, x, y, animation, dir ", x, y, animation, dir);
    const playerInfo = state.onlinePlayers.find(player => player.id === ws.playerId)
    const room = state.rooms[playerInfo.roomType][playerInfo.roomCode]
    const playerIndex = room.players.findIndex(player => player.id === ws.playerId)
    const playerObject = room.players[playerIndex]
    playerObject.updatePositions(x,y,animation,dir)
  },

  emitUpdate() {
    let players = state.rooms.openWorld["AAAA"].players
    players.forEach(player => {
      let data = players.filter(p => p.id !== player.id).map(player => {
        return {
          id: player.id,
          x: player.x,
          y: player.y,
          animation: player.animation
        }
      })

      if (player.readyState && data.length > 0) {
        player.ws.send(JSON.stringify({type:"room_positions_data", positions: data}))
      }
    })
  }
};