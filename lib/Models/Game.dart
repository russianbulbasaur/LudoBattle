import 'dart:convert';

import 'User.dart';

class Game{
  BigInt id = BigInt.zero;
  GameType type = GameType.player;
  double winning = 0.0;
  BigInt hostId = BigInt.zero;
  String hostName = "";
  double cost = 0;
  String player1 = "";
  String player2 = "";
  DateTime gameDate = DateTime.now();
  String code = "";

  Game.fromJson(String json,User user){
    Map<String,dynamic> decoded = jsonDecode(json);
    id = BigInt.parse(decoded["id"].toString());
    winning = double.parse(decoded["winning_amount"].toString());
    hostId = BigInt.parse(decoded["hostID"].toString());
    if(hostId==user.id) type = GameType.host;
    cost = double.parse(decoded["amount"].toString());
    hostName = decoded["hostName"];
  }

  Game.fromMap(Map decoded,User user){
    id = BigInt.parse(decoded["id"].toString());
    winning = double.parse(decoded["winning_amount"].toString());
    hostId = BigInt.parse(decoded["host_id"].toString());
    if(hostId==user.id) type = GameType.host;
    cost = double.parse(decoded["amount"].toString());
    hostName = decoded["host_name"];
  }

  String toJson(){
    return jsonEncode(this);
  }
}

enum GameType{
  host,player
}