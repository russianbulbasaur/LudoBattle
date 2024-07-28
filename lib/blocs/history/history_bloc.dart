import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../History/history_enum.dart';
import 'package:http/http.dart';
class HistoryBloc extends Cubit<List>{
  HistoryBloc():super([]);
  void getHistory(HistoryEnum choice) async{
    String tab = choice.getTabTitle();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      if(url==null) throw "url not set";
      String? userString = prefs.getString("user");
      if(userString==null) throw "user not set";
      User user = User.fromJson(userString);
      Response response = await get(Uri.parse("$url/user/history?tab=$tab"),
      headers: {"authorization":user.token});
      if(response.statusCode!=200) throw response.body;
      emit(jsonDecode(response.body));
    }catch(e){
      print("History Bloc : $e");
    }
  }
}
