import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/blocs/login/LoginBlocEvents.dart';
import 'package:ludo_macha/blocs/login/LoginBlocStates.dart';

class LoginBloc extends Bloc<LoginBlocEvent,LoginBlocState>{
  LoginBloc():super(PhoneNumberState("", "", Icons.send, "",
      Colors.red, "",LoginState.name,false)) {
    on<OtpRequestedEvent>((event,emit) => emit(SendingOTPState("", "",
        Icons.abc, "", Colors.black, "", LoginState.sendingOTP, true)));
    on<OTPSentEvent>((event,emit) => emit(OTPState("", "",
        Icons.abc, "", Colors.blue, "", LoginState.sendingOTP, true)));
    on<OtpVerificationEvent>((event,emit) => emit(VerifyingOTPState("", "",
        Icons.abc, "", Colors.green, "", LoginState.sendingOTP, true)));
    on<OTPVerifiedEvent>((event,emit) => emit(NameState("", "",
        Icons.abc, "", Colors.yellow, "", LoginState.sendingOTP, true)));
    on<NameUploadEvent>((event,emit) => emit(UploadingNameState("", "",
        Icons.abc, "", Colors.teal, "", LoginState.sendingOTP, true)));
    on<NameUploadedEvent>((event,emit){

    });
  }
}