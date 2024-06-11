import 'package:flutter/material.dart';

import 'login.dart';

class CustomRouter{
  static Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/login":
        return MaterialPageRoute(builder: (context){
          return const Login();
        });
        break;
      default:
        return MaterialPageRoute(builder: (context){
          return const Login();
        });
    }
  }
}