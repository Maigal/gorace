class Player{

  constructor(data){
    this.id = data.id;
    this.nickname = data.nickname;
    this.x = data.x || 100.0;
    this.y = data.y || 200.0;
    this.roomType = null;
    this.roomCode = null;
    this.animation = data.animation || "idle";
    this.eyes = data.eyes;
    this.body_color = data.body_color;
    this.dir = data.dir || 1;
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

  updatePositions(x,y,animation,dir) {
    this.x = x
    this.y = y
    this.animation = animation
    this.dir = dir
  }

  baseDataParsedForClient() {
    return {
      id: this.id,
      nickname: this.nickname,
      x: this.x,
      y: this.y,
      animation: this.animation,
      dir: this.dir,
      body_color: this.body_color,
      eyes: this.eyes
    }
  }

  parseForClient() {
    return {
      id: this.id,
      nickname: this.nickname,
      x: this.x,
      y: this.y,
      animation: this.animation,
      dir: this.dir
    }
  }

 }

 module.exports = Player;