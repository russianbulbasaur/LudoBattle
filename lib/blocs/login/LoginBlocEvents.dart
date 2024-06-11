abstract class LoginBlocEvent{}
class OtpRequestedEvent extends LoginBlocEvent{
  String phone;
  OtpRequestedEvent(this.phone);
}

class OtpVerificationEvent extends LoginBlocEvent{
  String otp;
  OtpVerificationEvent(this.otp);
}

class NameUploadEvent extends LoginBlocEvent{}

class OTPSentEvent extends LoginBlocEvent{}

class OTPVerifiedEvent extends LoginBlocEvent{}

class NameUploadedEvent extends LoginBlocEvent{}

