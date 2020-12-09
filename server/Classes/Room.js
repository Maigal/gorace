class Room {
  
  constructor(data){
    this.players = []
    this.type = data.roomType
    this.name = data.name
    this.scene = data.scene
  }

  addPlayer(player) {
    this.players.push(player)
  }

  removePlayer(playerId) {
    this.players = this.players.filter(player => player.id !== playerId)
  }
}

module.exports = Room;