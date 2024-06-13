import 'package:flutter/material.dart';
import 'package:ludo_macha/Screens/dashboard.dart';

import 'Dashboard/play.dart';
import 'Screens/login.dart';

class CustomRouter{
  static Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/login":
        return MaterialPageRoute(builder: (context){
          return const Login();
        });
      case "/play":
        return MaterialPageRoute(builder: (context){
          return const Play();
        });
      default:
        return MaterialPageRoute(builder: (context){
          return Dashboard();
        });
    }
  }
}