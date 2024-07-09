import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/Models/Game.dart';
import 'package:ludo_macha/repositories/play/play_repository.dart';

class OpenChallengesBloc extends Cubit<List<Game>>{
  late Isolate openChallengeIsolate;
  OpenChallengesBloc():super([]);
  void challengeScrapper() async{
    final resultPort = ReceivePort();
    openChallengeIsolate = await Isolate.spawn(PlayRepository().openChallengeScrapper,[resultPort.sendPort,RootIsolateToken.instance]);
    resultPort.listen((data){
      emit(data);
    });
  }
}