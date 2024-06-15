import 'dart:convert';

import 'User.dart';

class Game{
  int id = 0;
  GameType type = GameType.player;
  double winning = 0.0;
  int hostId = 0;
  String hostName = "";
  double cost = 0;
  Game(this.id,this.type,this.winning,this.hostName);

  Game.fromJson(String json,User user){
    Map decoded = jsonDecode(json);
    id = decoded["id"];
    winning = decoded["winning"];
    hostId = decoded["hostID"];
    if(hostId==user.id) type = GameType.host;
  }

  String toJson(){
    return jsonEncode(this);
  }
}

enum GameType{
  host,player
}