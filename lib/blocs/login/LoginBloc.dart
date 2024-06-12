import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/blocs/login/LoginBlocEvents.dart';
import 'package:ludo_macha/blocs/login/LoginBlocStates.dart';
import 'package:ludo_macha/repositories/login/login_repository.dart';

class LoginBloc extends Bloc<LoginBlocEvent,LoginBlocState>{
  final LoginRepository repo;
  LoginBloc(this.repo):super(PhoneNumberState(LoginState.phone,false)) {
    on<OtpRequestedEvent>((event,emit){
      emit(SendingOTPState(LoginState.sendingOTP, true));
      repo.sendOTP(event.phone,event.bloc);
    });
    on<OTPVerificationFailedEvent>((event,emit) => emit(ErrorState(LoginState.errorState,
        false, "Failed to send otp")));
    on<OTPSentEvent>((event,emit) => emit(OTPState(LoginState.otp, true)));
    on<OtpVerificationEvent>((event,emit) => emit(VerifyingOTPState(LoginState.verifyingOTP, true)));
    on<OTPVerifiedEvent>((event,emit) => emit(NameState(LoginState.name, true)));
    on<NameUploadEvent>((event,emit) => emit(UploadingNameState(LoginState.uploadingName, true)));
    on<NameUploadedEvent>((event,emit){

    });
  }
}