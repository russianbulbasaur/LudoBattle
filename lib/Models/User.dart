import 'dart:convert';

class User{
  String name = "";
  double balance = 0;
  String phone = "";
  String token = "";
  BigInt id = BigInt.zero;
  User(this.name,this.balance,this.phone,this.token,this.id);

  User.fromJson(String json){
    Map decoded = jsonDecode(json);
    name = decoded["name"];
    balance = decoded["balance"];
    phone = decoded["phone"];
    token = decoded["token"];
    id = decoded["id"];
  }

  String toJson(){
    return jsonEncode(this);
  }

}