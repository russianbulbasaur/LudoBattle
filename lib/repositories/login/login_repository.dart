import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/blocs/login/LoginBloc.dart';

import '../../blocs/login/LoginBlocEvents.dart';

class LoginRepository {
  late LoginBloc _bloc;
  FirebaseAuth auth = FirebaseAuth.instance;
  final BuildContext context;
  LoginRepository(this.context);
  sendOTP(String number,LoginBloc bloc) async{
    _bloc = bloc;
    await auth.verifyPhoneNumber(phoneNumber:"+91$number",verificationCompleted: (creds){
      _bloc.add(OTPVerifiedEvent());
    }, verificationFailed: (execption){
      print(execption);
      _bloc.add(OTPVerificationFailedEvent());
    }, codeSent: (id,resendId){
      _bloc.add(OTPSentEvent(id));
    }, codeAutoRetrievalTimeout: (time){

    });
    }

  authenticate(String otp,String id) async{
    _bloc.add(OTPVerifiedEvent());
    return;
    PhoneAuthCredential creds = PhoneAuthProvider.credential(verificationId: id, smsCode: otp);
    auth.signInWithCredential(creds).then((value){

    });
  }

  uploadName(String name){
    _bloc.add(NameUploadedEvent());
    return true;
  }
}