import 'package:equatable/equatable.dart';

abstract class LoginBlocState extends Equatable{
  final LoginStates state;
  const LoginBlocState(this.state);
}
enum LoginStates{
  phone,otp,name,error,finish
}


class PhoneState extends LoginBlocState{
  const PhoneState(super.state);
  @override
  List<Object?> get props => [super.state];
}

class OTPState extends LoginBlocState{
  final String phone;
  final String id;
  const OTPState(super.state,this.phone,this.id);
  @override
  List<Object?> get props => [super.state];

}

class NameState extends LoginBlocState{
  final String phone,otp,id;
  const NameState(super.state,this.phone,this.otp,this.id);
  @override
  List<Object?> get props => [super.state];
}


class ErrorState extends LoginBlocState{
  final String message;
  const ErrorState(super.state,this.message);
  @override
  List<Object?> get props => [super.state];
}

class FinishState extends LoginBlocState{
  const FinishState(super.state);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
