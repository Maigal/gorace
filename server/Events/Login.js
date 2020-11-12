const db = require('../db.js')

module.exports = function (client) {
  // registration related behaviour goes here...
  client.on('register', function (data) {
    // do stuff
  });
};