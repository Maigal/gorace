const RoomVersus =  require('./Classes/RoomVersus');
const RoomOpenWorld =  require('./Classes/RoomOpenWorld');
const db = require('./db');

const roomData = {
  openWorld: [
    {
      name: "Test open world",
      scene: "res://Levels/level_0.tscn"
    }
  ],
  versus: [
    {
      name: "Test run",
      scene: "res://Levels/level_1.tscn"
    }
  ]
}

module.exports = {
  onlinePlayers: [],
  disconnectPlayer: function(playerId) {
    const player = this.onlinePlayers.find(player => player.id === playerId)
    const user = db.get('users')
    .find({ id: player.id })
    user.assign({customization: player.customization})
    .write()
    this.onlinePlayers = this.onlinePlayers.filter(player => player.id !== playerId)
  },
  rooms: {
    openWorld: {
      'AAAA': new RoomOpenWorld({
        ...roomData.openWorld[0],
        roomType: "openWorld"
      })
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
          roomType: "versus",
          onClose: this.closeRoom.bind(this, "versus", targetCode)
        })
        return targetCode

      default:
        break;
    }
  },
  closeRoom: function(roomType, roomCode) {
    delete this.rooms[roomType][roomCode];
    console.log('remaaining rooms: ', this.rooms.versus) 
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