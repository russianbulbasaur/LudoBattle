import '../../../repositories/payment/payment_repository.dart';
import '../payment_bloc.dart';
import '../payment_events.dart';
import '../payment_states.dart';

class WithdrawBloc extends PaymentBloc{
  WithdrawBloc(super.initialState){
    on<StartPayment>(startPayment);
    on<EndPayment>(endPayment);
  }

  @override
  void startPayment(StartPayment event, emit) {
    PaymentRepository(this,event.amount).createWithdrawalRequest(event.upiId);
  }

  @override
  void endPayment(EndPayment event, emit) {
    if(event.success) emit(Ended(event.amount,"Withdrawal request placed"));
  }

}