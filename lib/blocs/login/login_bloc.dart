import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/blocs/login/login_bloc_events.dart';
import 'package:ludo_macha/blocs/login/login_bloc_states.dart';
import 'package:ludo_macha/repositories/login/login_repository.dart';

class LoginBloc extends Bloc<LoginBlocEvent,LoginBlocState>{
  static String? firebaseId;
  final LoginRepository repo;
  LoginBloc(this.repo):super(const PhoneState(LoginStates.phone)){
    on<SwitchToOTPEvent>(switchToOtp);
    on<SwitchToNameEvent>(switchToName);
    on<SignupEvent>(signup);
    on<ErrorEvent>(showError);
    on<SwitchToFinishEvent>(finish);
  }

  showError(ErrorEvent event,emit){
    emit(ErrorState(LoginStates.error, event.message));
  }

  errorCallback(String error){
    add(ErrorEvent(error));
  }

  switchToOtp(SwitchToOTPEvent event,emit) async{
    await repo.sendOTP(event.phone,
        errorCallback);
    while(firebaseId==null){
      await Future.delayed(const Duration(seconds: 2));
    }
    emit(OTPState(LoginStates.otp,event.phone,firebaseId!));
  }

  switchToName(SwitchToNameEvent event,emit) async{
    bool? doesUserExist = await repo.verify(event.phone,event.id,event.otp, errorCallback);
    if(doesUserExist!=null){
      if(doesUserExist) {
        emit(const FinishState(LoginStates.finish));
        return;
      }
      emit(NameState(LoginStates.name,event.phone,event.otp,event.id));
    }
  }

  signup(SignupEvent event,emit) async{
    bool? signupSuccess = await repo.signup(event.phone,event.otp,event.id,event.name,
        errorCallback);
    if(signupSuccess!=null && signupSuccess) {
      emit(const FinishState(LoginStates.finish));
    } else {
      errorCallback("Signup error");
    }
  }
  
  finish(SwitchToFinishEvent event,emit) async{
    emit(const FinishState(LoginStates.finish));
  }
}