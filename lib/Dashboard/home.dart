
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/Screens/dashboard.dart';
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
  "images/icons/play.svg"];
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
              child: Image.asset("images/icons/logo.png")),
          SizedBox(width: 0.w,),
            Column(mainAxisAlignment:MainAxisAlignment.center,
              children: [
              Text("Hey, Ankit",
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,))),
              Text('Your Wallet Balance is',
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,)),)
            ],),
        ],),),
        const Divider(),
        Expanded(flex: 1,child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //SvgPicture.asset("images/icons/balance.svg",height: 25.w,width: 25.w,),
          SizedBox(width: 10.w,),
          TextIcon(text: "100.0", icon: const Icon(Icons.currency_rupee),
          style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,)),),
          SizedBox(width: 3.w,),
          const Icon(Icons.refresh)
        ],),)
      ],),),);
  }


  Widget logout(){
    return TextButton(onPressed: (){},
        style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,44.h)),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                side: const BorderSide(color:Color(0xff282B2E),width: 2.3)))), child: Text("Logout",
          style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,)),));
  }

  Widget optionTile(String text,String icon,int index){
    return Expanded(
      child: GestureDetector(onTap: (){tileTap(index);},
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration:BoxDecoration(
              color: const Color(0xff0D1114),
              border: Border.all(color: const Color(0xff282B2E),width: 1.h),
              borderRadius: BorderRadius.circular(7.78.r)
          ),height: 100.h,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgPicture.asset(icon,width: 30,height: 30,),
            SizedBox(height: 5.h,),
            Text(text,style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,)),)
          ],),
        ),
      ),
    );
  }


  Widget buttons(){
    return Column(mainAxisSize: MainAxisSize.min,children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Expanded(
          child: TextButton(onPressed: (){
            Navigator.pushNamed(context, "/deposit");
          },
          style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,47.h)),
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
          side: const BorderSide(color:Color(0xff2AE716),width: 2.3)))), child:
          IconText(icon: SvgPicture.asset("images/icons/deposit.svg",width: 25.w,height: 25.w,),
            text: "Deposit",
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,)),)),
        ),
        SizedBox(width: 14.w,),
        Expanded(
          child: TextButton(onPressed: (){
            Navigator.pushNamed(context, "/withdraw");
          },
              style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,47.h)),
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                      side: const BorderSide(color: Color(0xff01A4F5),width: 2.3)))), child:
              IconText(icon: SvgPicture.asset("images/icons/withdraw.svg",width: 25.w,height: 25.w,),
                text: "Withdraw",
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,)),)),
        )
      ],),
      SizedBox(height: 10.h,),
      TextButton(onPressed: (){
        Navigator.pushNamed(context, "/play");
      },
          style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,47.h)),
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                  side: const BorderSide(color: Color(0xffC42F73),width: 2.3)))), child:
          IconText(icon: SvgPicture.asset("images/icons/play.svg",width: 23.w,height: 23.w,),
            text: "Play Game",
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,)),))
    ],);
  }

  Widget options(){
    return Column(children: [0,2,4].map((index){
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        optionTile(titles[index], icons[index],index),
        SizedBox(width: 10.w,),
        optionTile(titles[index+1], icons[index+1],index)
      ],);
    }).toList(),);
  }

  void tileTap(int index){
    switch(index){
      case 0:
        DashboardState.pageJumper.add(1);
        break;
      case 1:
        Navigator.pushNamed(context, "/leaderboard");
        break;
      case 2:
        Navigator.pushNamed(context,"/changename");
        break;
      case 3:
        DashboardState.pageJumper.add(2);
        break;
      case 4:
        DashboardState.pageJumper.add(3);
        break;
      case 5:
        Navigator.pushNamed(context, "/howtoplay");
        break;
    }
  }
}
