import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:ludo_macha/Models/Game.dart';
import 'package:ludo_macha/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameRepository{
  final Game? game;
  GameRepository(this.game);
  Future<BigInt?> createGame(int amount) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      if(url==null) throw "url not set";
      String? userString = prefs.getString("user");
      if(userString==null) throw "user not in prefs";
      User user = User.fromJson(userString);
      Response response = await post(Uri.parse("$url/game/create"),
      headers: {"authorization":user.token},
          body: {"amount":amount.toString()});
      if(response.statusCode!=200) throw response.body;
      return BigInt.parse(jsonDecode(response.body)["game_id"].toString());
    }catch(e){
      print("Create Game Bloc: $e");
      return null;
    }
  }

  Future<bool?> deleteGame(BigInt gameId) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      if(url==null) throw "url not set";
      String? userString = prefs.getString("user");
      if(userString==null) throw "user not in prefs";
      User user = User.fromJson(userString);
      Response response = await delete(Uri.parse("$url/game/delete"),
          headers: {"authorization":user.token},
      body: {"game_id":gameId.toString()});
      if(response.statusCode!=200) throw response.body;
      return true;
    }catch(e){
      print("Delete Game Bloc: $e");
      return false;
    }
  }

  Future<bool?> acceptGame() async{
    return null;
  

  }

  Future<bool?> sendCode(String code) async{
    return null;
  

  }

  void monitor(List args) async {
    try {
      BackgroundIsolateBinaryMessenger.ensureInitialized(
          args[1] as RootIsolateToken);
      SendPort sendPort = args[0];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      String? userString = prefs.getString("user");
      if (url == null) throw "url not set";
      if (userString == null) throw "user not in prefs";
      User user = User.fromJson(userString);
      Response response;
      while (true) {
        response = await get(Uri.parse("$url/game/status?gameId=${game!.id.toString()}"),
            headers: {"authorization": user.token});
        if(response.statusCode!=200) throw response.body;
        Game updatedGame = Game.fromMap(jsonDecode(response.body), user);
        sendPort.send(updatedGame);
        sleep(const Duration(seconds: 3));
      }
    } catch (e) {
      print("Game monitor : $e");
    }
  }
}