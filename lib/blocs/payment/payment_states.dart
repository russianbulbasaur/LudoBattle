abstract class PaymentState{
  final int amount;
  PaymentState(this.amount);
}

class InProgress extends PaymentState{
  InProgress(super.amount);
}

class Ended extends PaymentState{
  final String message;
  Ended(super.amount,this.message);
}
