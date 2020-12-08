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
      this.rooms.versus["AAAA"] = {
        ...roomData.versus[0],
        players: []
      }
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