const db = require('../db.js')
let state = require('../state.js')

module.exports = {

  join(ws, roomType, roomCode) {
    let user = state.onlinePlayers.find(u => u.id === ws.playerId)
    console.log('user, ', user)
    if (roomType === "openWorld") {
      let targetRoom = state.rooms.openWorld[roomCode]
      if (targetRoom) {
        targetRoom.players.push({user, x: 0, y: 0, animation: "idle"})
        return {
          status: "success",
          roomScene: state.rooms.openWorld[roomCode].scene,
        }
      } else {
        return {
          status: "error",
          error_message: "Room does not exist"
        }
      }
    }
  //   let dbUser = db.get('users').find({username: username}).value();
  //   if (dbUser) {
  //     if (dbUser.password === password) {
  //       if (!state.onlinePlayers.find(user => user.id === dbUser.id)) {
  //         player = {
  //           ws: ws,
  //           id: dbUser.id,
  //           nickname: dbUser.nickname,
  //           connectionId: ws.connectionId,
  //           currentRoomType: null,
  //           currentRoom: null     
  //         };
  //         state.onlinePlayers.push(player);
  //         return {
  //           status: "success",
  //           nickname: dbUser.nickname,
  //           id: dbUser.id,
  //         }
  //       }
  //     } else {
  //       return {
  //         status: "error",
  //         error_message: "Wrong password"
  //       }
  //     }
  //   } else {
  //     return {
  //       status: "error",
  //       error_message: "Username does not exist"
  //     }
  //   }
  }
};