
abstract class LoginBlocEvent{}

class SwitchToOTPEvent extends LoginBlocEvent{
  final String phone;
  SwitchToOTPEvent(this.phone);
}

class SwitchToNameEvent extends LoginBlocEvent{
  final String phone,otp,id;
  SwitchToNameEvent(this.phone,this.otp,this.id);
}


class ErrorEvent extends LoginBlocEvent{
  final String message;
  ErrorEvent(this.message);
}

class SignupEvent extends LoginBlocEvent{
  final String phone,otp,id,name;
  SignupEvent(this.phone,this.otp,this.id,this.name);
}

class SwitchToFinishEvent extends LoginBlocEvent{}


