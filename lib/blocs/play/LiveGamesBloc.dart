import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/Models/Game.dart';
import 'package:ludo_macha/Models/LiveGame.dart';
import 'package:ludo_macha/repositories/play/play_repository.dart';

class LiveGamesBloc extends Cubit<List<LiveGame>>{
  LiveGamesBloc():super([LiveGame("Ankit", "Shubham", 20),
  LiveGame("Garima", "Akshita", 50)]);
  void challengeScapper() async{
    PlayRepository repository = PlayRepository();
    while(true){
      emit(repository.liveGameScapper());
    }
  }
}