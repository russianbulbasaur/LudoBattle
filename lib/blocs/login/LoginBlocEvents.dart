import 'LoginBloc.dart';

abstract class LoginBlocEvent{}
class OtpRequestedEvent extends LoginBlocEvent{
  String phone;
  LoginBloc bloc;
  OtpRequestedEvent(this.phone,this.bloc);
}

class OtpVerificationEvent extends LoginBlocEvent{
  String otp;
  OtpVerificationEvent(this.otp);
}

class NameUploadEvent extends LoginBlocEvent{}

class OTPSentEvent extends LoginBlocEvent{
  String _id;
  OTPSentEvent(this._id);
}

class OTPVerifiedEvent extends LoginBlocEvent{}

class NameUploadedEvent extends LoginBlocEvent{}

class OTPVerificationFailedEvent extends LoginBlocEvent{}

