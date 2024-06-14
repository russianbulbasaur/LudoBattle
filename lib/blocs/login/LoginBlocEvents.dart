import 'package:ludo_macha/blocs/login/LoginBlocStates.dart';

import 'LoginBloc.dart';

abstract class LoginBlocEvent{}
class OtpRequestedEvent extends LoginBlocEvent{
  String phone;
  LoginBloc bloc;
  OtpRequestedEvent(this.phone,this.bloc);
}

class ResetState extends LoginBlocEvent{
  LoginBlocState prev;
  ResetState(this.prev);
}

class OtpVerificationEvent extends LoginBlocEvent{
  String otp;
  OtpVerificationEvent(this.otp);
}

class NameUploadEvent extends LoginBlocEvent{}

class OTPSentEvent extends LoginBlocEvent{
  final String _id;
  OTPSentEvent(this._id);
}

class OTPVerifiedEvent extends LoginBlocEvent{}

class NameUploadedEvent extends LoginBlocEvent{}

class OTPVerificationFailedEvent extends LoginBlocEvent{}


