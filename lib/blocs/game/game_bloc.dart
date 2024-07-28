import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/repositories/game/game_repository.dart';
import '../../Models/Game.dart';
import 'game_events.dart';
import 'game_states.dart';
class GameBloc extends Bloc<GameEvent,GameState> {
  final Game game;
  late GameRepository _gameRepository;
  GameBloc(this.game) : super(DefaultState()) {
    _gameRepository = GameRepository(game);
    on<DeleteGameEvent>(deleteGame);
    on<AcceptGameEvent>(acceptGame);
    on<CodeSharedEvent>(switchScreensToPlayer);
    on<GameAcceptedEvent>(switchScreensToHost);
    on<ShowStartPlayingEvent>(showStartPlaying);
  }

  void showStartPlaying(ShowStartPlayingEvent event,emit){
    emit(ShowStartPlayingState());
  }

  void switchScreensToHost(GameAcceptedEvent event,emit){
  }

  void switchScreensToPlayer(CodeSharedEvent event,emit){}

  void deleteGame(DeleteGameEvent event,emit) async{
    bool? gameDeleted = await _gameRepository.deleteGame(event.gameId);
    if(gameDeleted!=null && gameDeleted) emit(GameDeletedState());
  }

  void acceptGame(AcceptGameEvent event,emit) async{
    emit(GameAcceptedState(game));
    return;
    bool? gameAccepted = await _gameRepository.acceptGame();
    if(gameAccepted!=null && gameAccepted) emit(GameAcceptedState(game));
  }
}