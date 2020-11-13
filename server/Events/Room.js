const db = require('../db.js')
let state = require('../state.js')

module.exports = {

  join(ws, roomType, roomCode) {
    let user = state.onlinePlayers.find(u => u.id === ws.playerId)
    if (roomType === "openWorld") {
      let targetRoom = state.rooms.openWorld[roomCode]
      if (targetRoom) {
        targetRoom.players.push({...user, x: 0, y: 0, animation: "idle"})
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
    let user = state.onlinePlayers.find(u => u.id === ws.playerId)
    if (roomType === "openWorld") {
      let targetRoom = state.rooms.openWorld[roomCode]
      console.log("targetRoom.players", targetRoom.players, user);
      console.log("targetRoom ", targetRoom);
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
    }
  }
};