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
    switch (type){
      case "versus":
        let targetCode = idGenerator(this.rooms.versus)
        this.rooms.versus[targetCode] = new RoomVersus({
          ...roomData.versus[0],
          roomType: "versus"
        })
        return targetCode

      default:
        break;
    }
  }
}

function idGenerator(obj) {
  let result           = '';
  let characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  let charactersLength = characters.length;
  for ( let i = 0; i < 4; i++ ) {
     result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  if (!obj[result]) {
    return result;
  } else {
    return idGenerator(obj)
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