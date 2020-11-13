const db = require('../db.js')
let state = require('../state.js')

module.exports = {

  join(ws, roomType, roomCode) {
    let user = state.onlinePlayers.find(u => u.id === ws.playerId)
    if (roomType === "openWorld") {
      let targetRoom = state.rooms.openWorld[roomCode]
      if (targetRoom) {
        targetRoom.players.push({user, x: 0, y: 0, animation: "idle"})
        return {
          status: "success",
          roomScene: state.rooms.openWorld[roomCode].scene,
          otherPlayers: targetRoom.players.filter(player => player.id !== user.id)
        }
      } else {
        return {
          status: "error",
          error_message: "Room does not exist"
        }
      }
    }
  }
};