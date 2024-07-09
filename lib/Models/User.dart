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
    name = decoded["name"].toString();
    balance = double.parse(decoded["balance"].toString());
    phone = decoded["phone"].toString();
    token = decoded["token"].toString();
    id = BigInt.parse(decoded["id"].toString());
  }

  String toJson(){
    Map<String,dynamic> toBeEncoded = {};
    toBeEncoded["name"] = name;
    toBeEncoded["balance"] = balance;
    toBeEncoded["phone"] = phone;
    toBeEncoded["token"] = token;
    toBeEncoded["id"] = id.toString();
    return jsonEncode(toBeEncoded);
  }

}