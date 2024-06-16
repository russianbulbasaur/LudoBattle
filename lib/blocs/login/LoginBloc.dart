import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/blocs/login/LoginBlocEvents.dart';
import 'package:ludo_macha/blocs/login/LoginBlocStates.dart';
import 'package:ludo_macha/repositories/login/login_repository.dart';

class LoginBloc extends Bloc<LoginBlocEvent,LoginBlocState>{
  final LoginRepository repo;
  LoginBloc(this.repo):super(const PhoneNumberState(LoginState.phone,false)) {
    on<OtpRequestedEvent>((event,emit){
      emit(const SendingOTPState(LoginState.sendingOTP, true));
      repo.sendOTP(event.phone,event.bloc);
    });
    on<OTPVerificationFailedEvent>((event,emit) => emit(const ErrorState(LoginState.errorState,
        false, "Failed to verify otp")));
    on<OTPSentEvent>((event,emit) => emit(const OTPState(LoginState.otp, false)));
    on<OtpVerificationEvent>((event,emit){
      emit(VerifyingOTPState(LoginState.verifyingOTP, true));
      repo.authenticate("otp", "");
    });
    on<OTPVerifiedEvent>((event,emit) => emit(const NameState(LoginState.name, false)));
    on<NameUploadEvent>((event,emit){
      emit(const UploadingNameState(LoginState.uploadingName, true));
      repo.uploadName("name");
    });
    on<NameUploadedEvent>((event,emit) => emit(Finish(LoginState.finish, false)));
    on<ResetState>((event,emit) => emit(event.prev));
  }
}