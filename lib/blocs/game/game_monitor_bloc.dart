import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/Models/Game.dart';
import 'package:ludo_macha/repositories/game/game_repository.dart';

class GameMonitorBloc extends Cubit<Game>{
  static Isolate? gameMonitor;
  final Game game;
  GameMonitorBloc(super.initialState,this.game){
    monitor();
  }
  void monitor() async{
    GameRepository gameRepository = GameRepository(game);
    ReceivePort port = ReceivePort();
    gameMonitor = await Isolate.spawn(gameRepository.monitor, [port.sendPort,RootIsolateToken.instance]);
    port.listen((data){
      emit(data);
    });
  }
}