const db = require('../db.js');
const { onlinePlayers } = require('../state.js');
let state = require('../state.js')

module.exports = {
  join(ws, roomType, player, callback) {
    if (!state.matchmaking[roomType].find(p => p.id === player.id)) {
      state.matchmaking[roomType].push(player)
      if (state.matchmaking[roomType].length > 1) {
        let roomCode = state.createRoom("versus")
        state.matchmaking[roomType].forEach(pl => {
          pl.ws.send(JSON.stringify({type: "found_room", roomType, roomCode}))
        })
        state.matchmaking[roomType] = []
      }
    }
  }
}