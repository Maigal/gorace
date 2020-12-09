const RoomVersus =  require('./Classes/RoomVersus')

module.exports = {
  onlinePlayers: [],
  rooms: {
    openWorld: {
      'AAAA': {
        scene: "res://Levels/level_0.tscn",
        players: []
      }
    },
    versus: {}
  },
  matchmaking: {
    versus: []
  },
  createRoom: function(type) {
    if (type === "versus") {
      //console.log('this: ', this)
      // this.rooms.versus["AAAA"] = {
      //   ...roomData.versus[0],
      //   players: []
      // }
      this.rooms.versus["AAAA"] = new RoomVersus({
        ...roomData.versus[0],
        roomType: "versus"
      })
    }
    return "AAAA"
  }
}

const roomData = {
  versus: [
    {
      name: "Test run",
      scene: "res://Levels/level_1.tscn"
    }
  ]
}