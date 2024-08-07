import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ludo_macha/Dashboard/history.dart';
import 'package:ludo_macha/Dashboard/home.dart';
import 'package:ludo_macha/Dashboard/referrals.dart';
import 'package:ludo_macha/Dashboard/support.dart';
class Dashboard extends StatefulWidget {
  static String name = "";
  static double balance = 0;
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController();
  static StreamController<int> pageJumper = StreamController.broadcast();
  double iconSize = 26.w;
  @override
  void initState() {
    pageJumper.stream.listen((event) {
      _pageController.jumpToPage(event);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val){
        if(_pageController.page==0) {
          Navigator.pop(context);
        } else {
          _pageController.jumpToPage(0);
        }
      },
      child: SafeArea(
        child: Scaffold(backgroundColor: Colors.white,bottomNavigationBar: bottomNav(),
        body: PageView.builder(controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,page){
          switch(page){
            case 0:
              return const Home();
            case 1:
              return const Referrals();
            case 2:
              return const History();
            case 3:
              return const Support();
          }
          return Text(page.toString());
        },itemCount: 4
        )),
      ),
    );
  }

  Widget bottomNav(){
    return Container(decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
    height: 50.h,
    child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      optionHome(),
      optionReferral(),
      optionPlay(),
      optionHistory(),
      optionSupport()
    ],),),);
  }


  Widget makeIcon(IconData icon,String text){
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      Icon(icon),
      Text(text,style: const TextStyle(color: Colors.white,
          fontSize: 10),)
    ],);
  }


  Widget optionHome(){
    return GestureDetector(onTap: (){
      _pageController.jumpToPage(0);
    },child: makeIcon(Icons.home,"Home"),);
  }

  Widget optionReferral(){
    return GestureDetector(onTap: (){
      _pageController.jumpToPage(1);
    },child: makeIcon(Icons.person_add_alt_1_rounded,"Referrals"),);
  }

  Widget optionPlay(){
    return SizedBox(width: 40.h,height: 40.h,
      child: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, "/play");
      },
      shape: const CircleBorder(),backgroundColor: Colors.blueAccent,child: const Icon(Icons.videogame_asset_outlined,color: Colors.white,),),
    );
  }

  Widget optionHistory(){
    return GestureDetector(onTap: (){
      _pageController.jumpToPage(2);
    },child: makeIcon(Icons.history_edu,"History"),);
  }


  Widget optionSupport(){
    return GestureDetector(onTap: (){
      _pageController.jumpToPage(3);
    },child: makeIcon(Icons.support_agent,"Support"),);
  }
}
