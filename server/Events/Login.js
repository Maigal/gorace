const db = require('../db.js')
let state = require('../state.js')
const Player = require('../Classes/Player');

module.exports = {

  login(ws, username, password) {
    let dbUser = db.getUserFromDB(username)
    if (dbUser) {
      if (dbUser.password === password) {
        if (!state.onlinePlayers.find(user => user.id === dbUser.id)) {
          player = new Player({
            ws: ws,
            id: dbUser.id,
            nickname: dbUser.nickname,
            currentRoomType: null,
            currentRoom: null,
            customization: dbUser.customization,
            level: dbUser.level,
            exp: dbUser.exp
          });
          state.onlinePlayers.push(player);
          //state.createRoom("versus")
          return {
            status: "success",
            nickname: dbUser.nickname,
            id: dbUser.id,
            level: dbUser.level,
            exp: dbUser.level,
            customization: dbUser.customization
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