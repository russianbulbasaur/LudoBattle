import 'dart:convert';

import 'User.dart';

class Game{
  BigInt id = BigInt.zero;
  GameType type = GameType.player;
  double winning = 0.0;
  BigInt hostId = BigInt.zero;
  String hostName = "";
  String playerName = "";
  double cost = 0;
  DateTime gameDate = DateTime.now();
  GameStatus status = GameStatus.open;
  String code = "";

  Game.fromJson(String json,User user){
    Map<String,dynamic> decoded = jsonDecode(json);
    id = BigInt.parse(decoded["id"].toString());
    winning = double.parse(decoded["winning_amount"].toString());
    hostId = BigInt.parse(decoded["hostID"].toString());
    if(hostId==user.id) type = GameType.host;
    cost = double.parse(decoded["amount"].toString());
    hostName = decoded["hostName"].toString();
    playerName = decoded["playerName"].toString();
  }

  Game.fromMap(Map decoded,User user){
    id = BigInt.parse(decoded["id"].toString());
    winning = double.parse(decoded["winning_amount"].toString());
    hostId = BigInt.parse(decoded["host_id"].toString());
    if(hostId==user.id) type = GameType.host;
    status = getStatus(decoded["status"].toString());
    cost = double.parse(decoded["amount"].toString());
    hostName = decoded["hostName"].toString();
    playerName = decoded["playerName"].toString();
  }

  GameStatus getStatus(String status){
    switch(status){
      case "open":
        return GameStatus.open;
      case "waiting":
        return GameStatus.waiting;
      case "playing":
        return GameStatus.playing;
      case "ended":
        return GameStatus.ended;
      default:
        return GameStatus.ended;
    }
  }

  String toJson(){
    return jsonEncode(this);
  }
}

enum GameType{
  host,player
}

enum GameStatus{
  open,waiting,playing,ended
}