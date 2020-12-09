const db = require('../db.js');
const { onlinePlayers } = require('../state.js');
let state = require('../state.js')

module.exports = {
  join(ws, roomType, player) {
    if (!state.matchmaking[roomType].find(p => p.id === player.id)) {
      state.matchmaking[roomType].push(player)
      if (state.matchmaking[roomType].length > 1) {
        let roomCode = state.createRoom("versus")
        console.log('asd: ', state.rooms.versus)
        state.matchmaking[roomType].forEach(pl => {
          pl.ws.send(JSON.stringify({type: "found_room", roomType, roomCode}))
        })
        state.matchmaking[roomType] = []
      }
    }
  },
  leave(ws, roomType, player) {
    if (state.matchmaking[roomType].find(p => p.id === player.id)) {
      state.matchmaking[roomType] = state.matchmaking[roomType].filter(p => p.id !== player.id)
    }
  }
}