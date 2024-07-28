class LiveGame{
  String player1 = "";
  String player2 = "";
  double amount = 0;
  LiveGame.fromMap(Map decoded){
    amount = double.parse(decoded["amount"].toString());
    player1 = decoded["player1"].toString();
    player2 = decoded["player2"].toString();
  }
}