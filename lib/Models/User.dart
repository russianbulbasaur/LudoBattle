import 'dart:convert';

class User{
  String name = "";
  double amount = 0;
  String phone = "";
  int id = 0;
  User(this.name,this.amount,this.phone,this.id);

  User.fromUser(String json){
    Map decoded = jsonDecode(json);
    name = decoded["name"];
    amount = decoded["amount"];
    phone = decoded["phone"];
    id = decoded["id"];
  }

  String toJson(){
    return jsonEncode(this);
  }

}