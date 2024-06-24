import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ludo_macha/blocs/login/LoginBloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginRepository {
  late LoginBloc _bloc;
  FirebaseAuth auth = FirebaseAuth.instance;
  LoginRepository();
  sendOTP(String number,Function errorCallback) async{
    ConfirmationResult res;
    await auth.verifyPhoneNumber(phoneNumber:"+91$number",verificationCompleted: (creds){}, verificationFailed: (execption){
      errorCallback(execption);
    },
        codeSent: (id,resendId){
      LoginBloc.firebaseId = id;
    }, codeAutoRetrievalTimeout: (time){});
  }


  Future<bool?> verify(String phone,String id,String otp,Function errorCallback) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      if(url==null) throw "Url is null";
      Response response = await get(Uri.parse("$url/auth/verify?id=$id&phone=$phone&otp=$otp"));
      if(response.statusCode!=200) throw response;
      Map<String,dynamic> decodedResult = jsonDecode(response.body.toString());
      if(decodedResult.containsKey("token")){
        await prefs.setString("user", decodedResult.toString());
        return true;
      }
      return false;
    }catch(e){
      errorCallback(e.toString());
      print(e);
      return null;
    }
  }

  signup(String phone,String otp,String id,String name,Function errorCallback) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      if(url==null) throw "Url is null";
      Response response = await post(Uri.parse("$url/auth/signup"),
      body: {'phone':phone,'otp':otp,'id':id,'name':name});
      if(response.statusCode!=200) throw response;
      Map<String,dynamic> decodedResult = jsonDecode(response.body);
      if(decodedResult.containsKey("token")){
        await prefs.setString("user", decodedResult.toString());
        return true;
      }
      return false;
    }catch(e){
      errorCallback(e);
      print(e);
      return null;
    }
  }
}