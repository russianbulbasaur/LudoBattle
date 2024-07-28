abstract class GameEvent{}

class DeleteGameEvent extends GameEvent{
  final BigInt gameId;
  DeleteGameEvent(this.gameId);
}

class AcceptGameEvent extends GameEvent{}

class ShowStartPlayingEvent extends GameEvent{}

class GameAcceptedEvent extends GameEvent{}

class CodeSharedEvent extends GameEvent{
  String code;
  CodeSharedEvent(this.code);
}