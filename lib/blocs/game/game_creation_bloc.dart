
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/blocs/game/game_states.dart';
import 'package:ludo_macha/repositories/game/game_repository.dart';

class GameCreationBloc extends Cubit<GameState>{
  final GameRepository _gameRepository = GameRepository(null);
  GameCreationBloc():super(DefaultState());
  void createGame(int amount) async{
    BigInt? gameCreated = await _gameRepository.createGame(amount);
    if(gameCreated!=null){
      emit(GameCreatedState());
      return;
    }
    emit(GameErrorState());
  }
}