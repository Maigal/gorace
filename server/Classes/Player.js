class Player{

  constructor(data){
    this.id = data.id;
    this.nickname = data.nickname;
    this.x = data.x || 0;
    this.y = data.y || 0;
    this.currentRoomType = null;
    this.currentRoom = null;
    this.animation = data.animation || "idle";
    this.ws = data.ws;
    this.connectionId = data.ws.connectionId;
  }
 
  toString() {
    return JSON.stringify(this, this.replacer);
  }

  replacer(key, value) {
      if (key == "socket") return undefined;
      else return value;
  }

  parseForClient() {
    return {
      id: this.id,
      nickname: this.nickname,
      x: this.x,
      y: this.y,
      animation: this.animation
    }
  }

 }

 module.exports = Player;