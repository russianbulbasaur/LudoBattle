import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ludo_macha/Screens/login.dart';

abstract class LoginBlocState extends Equatable{
  final LoginState enumState;
  final bool showLoader;
  const LoginBlocState(this.enumState,this.showLoader);
}

enum LoginState{
  phone,sendingOTP,otp,verifyingOTP,name,uploadingName,errorState
}

class PhoneNumberState extends LoginBlocState{
  PhoneNumberState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class SendingOTPState extends LoginBlocState{
  SendingOTPState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class OTPState extends LoginBlocState{
  OTPState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class ErrorState extends LoginBlocState{
  final String text;
  ErrorState(super.enumState,super.showLoader,this.text);

  @override
  // TODO: implement props
  List<Object?> get props => [enumState];
}

class VerifyingOTPState extends LoginBlocState{
  VerifyingOTPState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class NameState extends LoginBlocState{
  NameState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class UploadingNameState extends LoginBlocState{
  UploadingNameState(super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}
