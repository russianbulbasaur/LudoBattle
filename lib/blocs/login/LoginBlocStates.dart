import 'package:equatable/equatable.dart';

abstract class LoginBlocState extends Equatable{
  final LoginState enumState;
  final bool showLoader;
  const LoginBlocState(this.enumState,this.showLoader);
}

enum LoginState{
  phone,sendingOTP,otp,verifyingOTP,name,uploadingName,errorState
}

class PhoneNumberState extends LoginBlocState{
  const PhoneNumberState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class SendingOTPState extends LoginBlocState{
  const SendingOTPState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class OTPState extends LoginBlocState{
  const OTPState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class ErrorState extends LoginBlocState{
  final String text;
  const ErrorState(super.enumState,super.showLoader,this.text);

  @override
  // TODO: implement props
  List<Object?> get props => [enumState];
}

class VerifyingOTPState extends LoginBlocState{
  const VerifyingOTPState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class NameState extends LoginBlocState{
  const NameState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class UploadingNameState extends LoginBlocState{
  const UploadingNameState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}
