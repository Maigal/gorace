const low = require('lowdb')
const FileSync = require('lowdb/adapters/FileSync')

const adapter = new FileSync(__dirname + '/db.json')
const database = low(adapter)

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
        parsedData.customization[key] = player.customization[key]
      }
    })

    user.assign({customization: parsedData.customization})
    .write()
  }
}

module.exports = db;
