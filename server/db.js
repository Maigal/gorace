const low = require('lowdb')
const FileSync = require('lowdb/adapters/FileSync')

const adapter = new FileSync(__dirname + '/db.json')
const database = low(adapter)

const userTemplate = {
  "username": "",
  "password": "",
  "nickname": "",
  "level": 1,
  "exp": 0,
  "customization": {
    "body_color": 0,
    "body_equip": 0,
    "eyes": 0,
    "eyes_color": 0,
    "head": 0,
    "pants": 0,
    "pattern": 0
  }
}

const db = {

  getUserFromDB(username) {
    return database.get('users').find({username: username}).value();
  },

  saveLogoutSettings(player) {
    const user = database.get('users')
    .find({ id: player.id })

    let parsedData = {
      customization: user.value().customization
    }

    Object.keys(player.customization).forEach(key => {
      if (typeof player.customization[key] === "number") {
        console.log('int :', key)
        parsedData.customization[key] = player.customization[key]
      } else {
        console.log('not int')
      }
    })

    console.log('new cust :', player.customization)

    user.assign({customization: parsedData.customization})
    .write()
  },

  createUser(username, password) {
    const length = database.get('users').size().value()

    const user = userTemplate
    user.username = username
    user.nickname = username
    user.password = password
    user.id = length

    database
    .get('users')
    .push(user)
    .write()

    if (this.getUserFromDB(username)) {
      return true
    } else {
      return false
    }
  }
}

module.exports = db;
