import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ludo_macha/common/IconAndText.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> titles = ["Referrals","Leaderboard","Change name","History","Support",
  "How to Play"];
  List<String> icons = ["images/icons/referral.svg","images/icons/leaderboard.svg",
  "images/icons/change.svg","images/icons/history.svg","images/icons/support.svg",
  "images/icons/change.svg"];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColorDark,
      title: Text("Dashboard",style: TextStyle(fontSize: 16.sp),),
      automaticallyImplyLeading: false,
    ),
      backgroundColor: Colors.black,
      body:Padding(
      padding: EdgeInsets.all(20.w),
      child: SingleChildScrollView(
        child: Column(children: [
          amountCard(),
          SizedBox(height: 10.h,),
          buttons(),
          SizedBox(height: 15.h,),
          options(),
          logout()
        ],),
      ),
    ),));
  }

  Widget amountCard(){
    return Card(color: Colors.white10,child:
    SizedBox(height: MediaQuery.of(context).size.height/3.8,
      child: Column(children: [
        Expanded(flex: 2,child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 130.h,height: 130.h,padding: EdgeInsets.all(20.w),
              child: SvgPicture.asset("images/icons/logo.svg"),),
          SizedBox(width: 0.w,),
          const Text("Hey Ankit\nHere is your balance"),
        ],),),
        const Divider(),
        Expanded(flex: 1,child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SvgPicture.asset("images/icons/balance.svg",height: 25.w,width: 25.w,),
          SizedBox(width: 10.w,),
          TextIcon(text: "100.0", icon: const Icon(Icons.currency_rupee)),
          SizedBox(width: 3.w,),
          const Icon(Icons.refresh)
        ],),)
      ],),),);
  }


  Widget logout(){
    return TextButton(onPressed: (){},
        style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                side: const BorderSide(color: Colors.white12,width: 2.3)))), child: Text("Logout",
          style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold,color: Colors.white),));
  }

  Widget optionTile(String text,String icon){
    return Expanded(
      child: SizedBox(height: 100.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Card(color: Colors.black26,child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgPicture.asset(icon,width: 30,height: 30,),
            SizedBox(height: 5.h,),
            Text(text)
          ],),),
        ),
      ),
    );
  }


  Widget buttons(){
    return Column(mainAxisSize: MainAxisSize.min,children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Expanded(
          child: TextButton(onPressed: (){},
          style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
          side: const BorderSide(color: Colors.green,width: 2.3)))), child:
          IconText(icon: SvgPicture.asset("images/icons/deposit.svg",width: 20.w,height: 20.w,),
            text: "Deposit",
            style: TextStyle(fontSize: 10.sp,
                fontWeight: FontWeight.bold,color: Colors.white),)),
        ),
        SizedBox(width: 14.w,),
        Expanded(
          child: TextButton(onPressed: (){},
              style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                      side: const BorderSide(color: Colors.blue,width: 2.3)))), child:
              IconText(icon: SvgPicture.asset("images/icons/withdraw.svg",width: 20.w,height: 20.w,),
                text: "Withdraw",
                style: TextStyle(fontSize: 10.sp,
                    fontWeight: FontWeight.bold,color: Colors.white),)),
        )
      ],),
      SizedBox(height: 10.h,),
      TextButton(onPressed: (){},
          style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                  side: const BorderSide(color: Colors.pink,width: 2.3)))), child:
          IconText(icon: SvgPicture.asset("images/icons/play.svg",width: 20.w,height: 20.w,),
            text: "Play Game",
            style: TextStyle(fontSize: 10.sp,
                fontWeight: FontWeight.bold,color: Colors.white),))
    ],);
  }

  Widget options(){
    return Column(children: [0,2,4].map((index){
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        optionTile(titles[index], icons[index]),
        SizedBox(width: 5.w,),
        optionTile(titles[index+1], icons[index+1])
      ],);
    }).toList(),);
  }
}
