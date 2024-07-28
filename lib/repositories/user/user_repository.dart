import 'package:ludo_macha/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
class UserRepository{
  Future<bool> changeName(String newName) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      String? userString = prefs.getString("user");
      if(url==null) throw "url not set";
      if(userString==null) throw "user not in prefs";
      User user = User.fromJson(userString);
      Response response = await patch(Uri.parse("$url/user/change-name"),headers: {
        "authorization":user.token
      },
      body: {"name":newName});
      if(response.statusCode==200) return true;
      throw response.body;
    }catch(e){
      print("Change name bloc : $e");
      return false;
    }
  }
}