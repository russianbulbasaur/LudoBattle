import 'package:flutter/material.dart';
import 'package:ludo_macha/Models/User.dart';
import 'package:ludo_macha/Screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void checkLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("url", "http://192.168.31.6:2500");
    if(prefs.containsKey("user")){
      User user = User.fromJson((prefs.getString("user")!));
      Dashboard.balance = user.balance;
      Dashboard.name = user.name;
      Navigator.pushReplacementNamed(context, "/dashboard");
      return;
    }
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
