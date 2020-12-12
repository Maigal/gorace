const Room = require("./Room");

class RoomVersus extends Room {

  constructor(data) {
    super(data)
    this.maxPlayers = 2
  }

  addPlayer(player) {
    super.addPlayer(player)
    if (this.players.length === this.maxPlayers) {
      this.startRoom()
    }
  }

  removePlayer(playerId) {
    super.removePlayer(playerId)
    if (this.players.length < this.maxPlayers) {
      this.closeRoom()
    }
  }

  startRoom() {
    // START ROOm
  }

  closeRoom() {
    
  }

}

module.exports = RoomVersus