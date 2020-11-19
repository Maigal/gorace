const db = require('../db.js')
let state = require('../state.js')
const Player = require('../Classes/Player');

module.exports = {

  login(ws, username, password) {
    let dbUser = db.get('users').find({username: username}).value();
    if (dbUser) {
      if (dbUser.password === password) {
        if (!state.onlinePlayers.find(user => user.id === dbUser.id)) {
          player = new Player({
            ws: ws,
            id: dbUser.id,
            nickname: dbUser.nickname,
            currentRoomType: null,
            currentRoom: null,
            color: dbUser.color,
            eyes: dbUser.eyes,
            level: dbUser.level,
            exp: dbUser.exp
          });
          state.onlinePlayers.push(player);
          return {
            status: "success",
            nickname: dbUser.nickname,
            id: dbUser.id,
            level: dbUser.level,
            exp: dbUser.level,
            color: dbUser.color,
            eyes: dbUser.eyes
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