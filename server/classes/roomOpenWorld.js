const Room = require("./room");

class RoomOpenWorld extends Room {

  constructor(data) {
    super(data)
  }

  addPlayer(player) {
    super.addPlayer(player)
  }

  removePlayer(playerId) {
    super.removePlayer(playerId)
  }

}

module.exports = RoomOpenWorld