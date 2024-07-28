import 'package:ludo_macha/blocs/payment/payment_bloc.dart';
import 'package:ludo_macha/blocs/payment/payment_events.dart';

import '../../../repositories/payment/payment_repository.dart';
import '../payment_states.dart';

class DepositBloc extends PaymentBloc{
  DepositBloc(super.initialState){
    on<StartPayment>(startPayment);
    on<EndPayment>(endPayment);
  }

  @override
  void startPayment(StartPayment event, emit) {
    PaymentRepository(this,event.amount).initiatePayment();
  }

  @override
  void endPayment(EndPayment event, emit) {
    if(event.success) emit(Ended(event.amount,"Amount deposited"));
  }

}