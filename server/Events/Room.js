const db = require('../db.js');
const { onlinePlayers } = require('../state.js');
let state = require('../state.js')
let Matchmaking = require('./Matchmaking.js')

module.exports = {

  join(ws, roomType, roomCode) {
    let player = state.onlinePlayers.find(u => u.id === ws.playerId)
    let playerIndex = state.onlinePlayers.findIndex(u => u.id === ws.playerId)
    
    if (roomCode) {
      let targetRoom = state.rooms[roomType][roomCode]
      if (targetRoom) {
        state.onlinePlayers[playerIndex].roomType = roomType
        state.onlinePlayers[playerIndex].roomCode = roomCode
        
        targetRoom.players.push(player)
        return {
          status: "success",
          roomType,
          roomCode,
          roomScene: state.rooms[roomType][roomCode].scene
        }
      } else {
        return {
          status: "error",
          error_message: "Room does not exist"
        }
      }
    } else {
      Matchmaking.join(ws, roomType, player)
      return {
        status: "success"
      }
    }

  },

  leave(ws, roomType, roomCode) {
    let player = state.onlinePlayers.find(u => u.id === ws.playerId)
    let playerIndex = state.onlinePlayers.findIndex(u => u.id === ws.playerId)

    if (roomCode) {
      let targetRoom = state.rooms[roomType][roomCode]
      // if (targetRoom) {
      //   state.onlinePlayers[playerIndex].roomType = roomType
      //   state.onlinePlayers[playerIndex].roomCode = roomCode
        
      //   targetRoom.players.push(player)
      //   return {
      //     status: "success",
      //     roomType,
      //     roomCode,
      //     roomScene: state.rooms[roomType][roomCode].scene
      //   }
      // } else {
      //   return {
      //     status: "error",
      //     error_message: "Room does not exist"
      //   }
      // }
    } else {
      Matchmaking.leave(ws, roomType, player)
      return {
        status: "success"
      }
    }

  },

  joined(ws, roomType, roomCode) {
    //console.log("ws, roomType, roomCode ", ws, roomType, roomCode);
    let user = state.onlinePlayers.find(u => u.id === ws.playerId)
    let targetRoom = state.rooms[roomType][roomCode]
    // console.log("targetRoom.players", targetRoom.players, user);
    if (targetRoom && targetRoom.players.find(player => player.id == user.id)) {
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
  },

  updatePosition(ws, x, y, animation, dir) {
   // console.log("ws, x, y, animation, dir ", x, y, animation, dir);
    const playerInfo = state.onlinePlayers.find(player => player.id === ws.playerId)
    const room = state.rooms[playerInfo.roomType][playerInfo.roomCode]
    const playerIndex = room.players.findIndex(player => player.id === ws.playerId)
    const playerObject = room.players[playerIndex]
    playerObject.updatePositions(x,y,animation,dir)
  },

  playerDeath(ws, dirX, dirY, distX, distY, force) {
    const playerInfo = state.onlinePlayers.find(player => player.id === ws.playerId)
    const targetRoom = state.rooms[playerInfo.roomType][playerInfo.roomCode]
    if (targetRoom && targetRoom.players.find(player => player.id == ws.playerId)) {
      return {
        status: "success",
        player: targetRoom.players.find(player => player.id == ws.playerId),
        otherPlayers: targetRoom.players.filter(player => player.id !== ws.playerId),
        deathData: {dirX, dirY, distX, distY, force}
      }
    } else {
      return {
        status: "error",
        error_message: "Player not in room?"
      }
    }
  },

  emitUpdate() {
    let activeRooms = []
    Object.keys(state.rooms.openWorld).forEach(room => {
      activeRooms.push(state.rooms.openWorld[room])
    })
    Object.keys(state.rooms.versus).forEach(room => {
      activeRooms.push(state.rooms.versus[room])
    })

    activeRooms.forEach(room => {
      let players = room.players
      players.forEach(player => {
        let data = players.filter(p => p.id !== player.id).map(player => {
          return {
            id: player.id,
            x: player.x || 0,
            y: player.y || 0,
            animation: player.animation || "idle",
            dir: player.dir || 1
          }
        })

        if (player.ws.readyState && data.length > 0) {
          player.ws.send(JSON.stringify({type:"update_other_players_positions", players: data}))
        }
      })
    })
    
  }
};