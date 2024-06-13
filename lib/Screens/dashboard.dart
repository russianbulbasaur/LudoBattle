import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ludo_macha/Dashboard/history.dart';
import 'package:ludo_macha/Dashboard/home.dart';
import 'package:ludo_macha/Dashboard/play.dart';
import 'package:ludo_macha/Dashboard/referrals.dart';
import 'package:ludo_macha/Dashboard/support.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController _pageController = PageController();
  double iconSize = 26.w;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white,bottomNavigationBar: bottomNav(),
      body: PageView.builder(controller: _pageController,
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
      Text(text,style: TextStyle(color: Colors.white,
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
      },child: Icon(Icons.videogame_asset_outlined,color: Colors.white,),
      shape: CircleBorder(),backgroundColor: Colors.blueAccent,),
    );
  }

  Widget optionHistory(){
    return GestureDetector(onTap: (){
      _pageController.jumpToPage(3);
    },child: makeIcon(Icons.history_edu,"History"),);
  }


  Widget optionSupport(){
    return GestureDetector(onTap: (){
      _pageController.jumpToPage(4);
    },child: makeIcon(Icons.support_agent,"Support"),);
  }
}
