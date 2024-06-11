import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ludo_macha/login.dart';

abstract class LoginBlocState extends Equatable{
  final String heading;
  final String text;
  final LoginState enumState;
  final IconData buttonIcon;
  final String buttonText;
  final Color primary;
  final String hint;
  final bool showLoader;
  const LoginBlocState(this.heading,this.text,this.buttonIcon,
      this.buttonText,this.primary,this.hint,this.enumState,this.showLoader);
}

enum LoginState{
  phone,sendingOTP,otp,verifyingOTP,name,uploadingName
}

class PhoneNumberState extends LoginBlocState{
  PhoneNumberState(super.heading, super.text, super.buttonIcon,
      super.buttonText, super.primary, super.hint,super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class SendingOTPState extends LoginBlocState{
  SendingOTPState(super.heading, super.text, super.buttonIcon, super.buttonText,
      super.primary, super.hint,super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class OTPState extends LoginBlocState{
  OTPState(super.heading, super.text, super.buttonIcon,
      super.buttonText, super.primary, super.hint,super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class VerifyingOTPState extends LoginBlocState{
  VerifyingOTPState(super.heading, super.text, super.buttonIcon, super.buttonText,
      super.primary, super.hint,super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class NameState extends LoginBlocState{
  NameState(super.heading, super.text, super.buttonIcon, super.buttonText,
      super.primary, super.hint,super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}

class UploadingNameState extends LoginBlocState{
  UploadingNameState(super.heading, super.text, super.buttonIcon, super.buttonText,
      super.primary, super.hint,super.enumState,super.showLoader);
  @override
  List<Object?> get props => [enumState];
}
