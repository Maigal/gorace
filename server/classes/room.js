class Room {
  
  constructor(data){
    this.players = []
    this.type = data.roomType
    this.name = data.name
    this.scene = data.scene
    this.maxPlayers = 99
  }

  addPlayer(player) {
    this.players.push(player)
  }

  removePlayer(playerId) {
    this.players = this.players.filter(player => player.id !== playerId)
    this.players.forEach(pl => {
      pl.ws.send(JSON.stringify({
        type: "disconnect_player",
        playerId: playerId
      }));
    })
    
  }
}

module.exports = Room;