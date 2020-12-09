const Room = require("./Room");

class RoomVersus extends Room {

  constructor(data) {
    super(data)
    console.log('roomversus, ', this)
  }

}

module.exports = RoomVersus