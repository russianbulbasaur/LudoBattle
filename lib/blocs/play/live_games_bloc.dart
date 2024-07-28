import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/Models/LiveGame.dart';
import 'package:ludo_macha/repositories/play/play_repository.dart';

class LiveGamesBloc extends Cubit<List<LiveGame>>{
  late Isolate liveGamesIsolate;
  LiveGamesBloc():super([]);
  void liveGameScrapper() async{
    ReceivePort port = ReceivePort();
    liveGamesIsolate = await Isolate.spawn(PlayRepository().liveGameScrapper, [port.sendPort,RootIsolateToken.instance]);
    port.listen((data){
      emit(data);
    });
  }
}