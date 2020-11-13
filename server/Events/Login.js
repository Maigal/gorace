const db = require('../db.js')
let state = require('../state.js')

module.exports = {

  login(ws, username, password) {
    let dbUser = db.get('users').find({username: username}).value();
    if (dbUser) {
      if (dbUser.password === password) {
        if (!state.onlinePlayers.find(user => user.id === dbUser.id)) {
          player = {
            ws: WaveShaperNode,
            id: dbUser.id,
            nickname: dbUser.nickname,
            connectionId: ws.connectionId,
            currentRoomType: null,
            currentRoom: null     
          };
          state.onlinePlayers.push(player);
          return {
            status: "success",
            nickname: dbUser.nickname,
            id: dbUser.id,
          }
        } else {
          return {
            status: "error",
            error_message: "User already logged in!"
          }
        }
      } else {
        return {
          status: "error",
          error_message: "Wrong password!"
        }
      }
    } else {
      return {
        status: "error",
        error_message: "Username does not exist!"
      }
    }
  }
};