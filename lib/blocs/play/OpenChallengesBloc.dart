import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/Models/Game.dart';
import 'package:ludo_macha/repositories/play/play_repository.dart';

class OpenChallengesBloc extends Cubit<List<Game>>{
  OpenChallengesBloc():super([Game(1, GameType.host, 10,"Someone"),
  Game(2, GameType.player, 12,"Someone2")]);
  void challengeScapper() async{
    PlayRepository repository = PlayRepository();
    while(true){
      emit(repository.openChallengeScapper());
    }
  }
}