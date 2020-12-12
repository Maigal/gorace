const Room = require("./Room");

const STATUS = {
  WAITING: 'waiting',
  STARTED: 'started',
  FINISHED: 'finished'
}

class RoomVersus extends Room {

  constructor(data) {
    super(data)
    this.onClose = data.onClose
    this.maxPlayers = 2
    this.playerList = []
    this.winner = null
    this.status = STATUS.WAITING
  }

  addPlayer(player) {
    super.addPlayer(player)
    if (this.players.length === this.maxPlayers) {
      this.startRoom()
    }
  }

  removePlayer(playerId) {
    super.removePlayer(playerId)
    console.log('remaining players: ', this.players.map(p => p.id))
    if (this.players.length === 0) {
      this.closeRoom()
    } else if (this.status !== STATUS.FINISHED && this.players.length < this.maxPlayers) {
      this.endRoom()
    }
  }

  startRoom() {
    this.playerList = [...this.players]
    this.status = STATUS.STARTED
  }

  playerReachedGoal(playerId) {
    if (this.status === STATUS.STARTED) {
      this.status = STATUS.FINISHED
      this.winner = this.players.find(pl => pl.id === playerId)
      this.players.forEach(pl => {
        pl.ws.send(JSON.stringify({
          type: "room_result",
          result: pl.id === this.winner.id ? "victory" : "defeat"
        }))
      })
      
    } 
  }

  endRoom() {
    if (this.players.length === 1) {
      this.winner = this.players[0]
      this.players[0].ws.send(JSON.stringify({
        type: "room_result",
        result: "victory"
      }))
      
    }
  }

  closeRoom() {
    this.onClose()
  }

}

module.exports = RoomVersus