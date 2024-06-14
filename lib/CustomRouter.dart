import 'package:flutter/material.dart';
import 'package:ludo_macha/Home/deposit.dart';
import 'package:ludo_macha/Home/howtoplay.dart';
import 'package:ludo_macha/Home/leaderboard.dart';
import 'package:ludo_macha/Home/withdraw.dart';
import 'package:ludo_macha/Screens/dashboard.dart';

import 'Dashboard/play.dart';
import 'Home/changename.dart';
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
      case "/leaderboard":
        return MaterialPageRoute(builder: (context){
          return const Leaderboard();
        });
      case "/withdraw":
        return MaterialPageRoute(builder: (context){
          return const Withdraw();
        });
      case "/deposit":
        return MaterialPageRoute(builder: (context){
          return const Deposit();
        });
      case "/howtoplay":
        return MaterialPageRoute(builder: (context){
          return const HowToPlay();
        });
      case "/changename":
        return MaterialPageRoute(builder: (context){
          return const ChangeName();
        });
      default:
        return MaterialPageRoute(builder: (context){
          return const Dashboard();
        });
    }
  }
}