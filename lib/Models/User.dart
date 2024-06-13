import 'dart:convert';

class User{
  String name = "";
  double amount = 0;
  String phone = "";
  User(this.name,this.amount,this.phone);

  User.fromUser(String json){
    Map decoded = jsonDecode(json);
    name = decoded["name"];
    amount = decoded["amount"];
    phone = decoded["phone"];
  }

  String toJson(){
    return jsonEncode(this);
  }

}