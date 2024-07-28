import 'package:ludo_macha/Models/Game.dart';

abstract class GameState{}


class DefaultState extends GameState{}

class GameCreatedState extends GameState{}

class GameDeletedState extends GameState{}

class ShowStartPlayingState extends GameState{}

class GameAcceptedState extends GameState{
  final Game game;
  GameAcceptedState(this.game);
}

class CodeSharedState extends GameState{}

class GameErrorState extends GameState{}