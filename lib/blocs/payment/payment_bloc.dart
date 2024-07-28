import 'package:flutter_bloc/flutter_bloc.dart';

import 'payment_events.dart';
import 'payment_states.dart';

abstract class PaymentBloc extends Bloc<PaymentEvent,PaymentState>{
  PaymentBloc(super.initialState);

  void startPayment(StartPayment event,emit);

  void endPayment(EndPayment event,emit);
}