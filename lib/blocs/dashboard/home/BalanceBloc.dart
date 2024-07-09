import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:ludo_macha/Screens/dashboard.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ludo_macha/Models/User.dart';
class BalanceBloc extends Cubit<User>{
  BalanceBloc():super(User(Dashboard.name, Dashboard.balance, "", "", BigInt.zero));
  loadBalance() async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userString = await prefs.getString("user");
      String? url = await prefs.getString("url");
      if(userString==null) throw "user not in prefs";
      if(url==null) throw "url is null";
      User user = User.fromJson(userString);
      Response response = await get(Uri.parse("$url/user/balance"),
      headers: {"authorization":user.token});
      if(response.statusCode!=200) throw "Error";
      Map<String,dynamic> decodedResponse = jsonDecode(response.body.toString());
      if(!decodedResponse.containsKey("balance")) throw response.body;
      user.balance = double.parse(decodedResponse["balance"].toString());
      user.name = decodedResponse["name"].toString();
      await prefs.setString("user", user.toJson().toString());
      emit(user);
    }catch(e){
      print("Balance Bloc : $e");
    }
  }
}