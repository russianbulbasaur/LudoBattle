import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Game.dart';
import '../../Models/LiveGame.dart';
import 'package:ludo_macha/Models/User.dart';
class PlayRepository{
  void openChallengeScrapper(List<dynamic> args) async{
    BackgroundIsolateBinaryMessenger.ensureInitialized(args[1] as RootIsolateToken);
    SendPort port = args[0];
    late Response response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      String? userString = prefs.getString("user");
      if(url==null) throw "url not set";
      if(userString==null) throw "user not in prefs";
      User user = User.fromJson(userString);
      while (true) {
        response = await get(Uri.parse("$url/game/open"),
        headers: {"authorization":user.token});
        List<dynamic> gamesMap = jsonDecode(response.body);
        List<Game> games = [];
        Game game;
        for(dynamic gameMap in gamesMap){
          game = Game.fromMap(gameMap, user);
          if(game.type==GameType.host) {
            games.insert(0, game);
          } else {
            games.add(game);
          }
        }
        port.send(games);
        sleep(const Duration(seconds: 5));
      }
    }catch(e){
      print("Response ${response.body}");
      print("Open Challenge Scrapper : $e");
    }
  }

  void liveGameScrapper(List<dynamic> args) async{
    BackgroundIsolateBinaryMessenger.ensureInitialized(args[1] as RootIsolateToken);
    SendPort port = args[0];
    late Response response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      String? userString = prefs.getString("user");
      if(url==null) throw "url not set";
      if(userString==null) throw "user not in prefs";
      User user = User.fromJson(userString);
      while (true) {
        response = await get(Uri.parse("$url/game/live"),
            headers: {"authorization":user.token});
        List<dynamic> gamesMap = jsonDecode(response.body);
        List<LiveGame> games = [];
        for(dynamic gameMap in gamesMap){
          games.add(LiveGame.fromMap(gameMap));
        }
        port.send(games);
        sleep(const Duration(seconds: 5));
      }
    }catch(e){
      print("Response ${response.body}");
      print("Live Game Scrapper : $e");
    }
  }

}