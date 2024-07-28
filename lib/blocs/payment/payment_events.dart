abstract class PaymentEvent{}

class StartPayment extends PaymentEvent{
  final int amount;
  String? upiId;
  StartPayment(this.amount,{this.upiId});
}

class EndPayment extends PaymentEvent{
  final bool success;
  final int amount;
  EndPayment(this.success,this.amount);
}