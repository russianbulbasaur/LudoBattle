import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
import 'package:ludo_macha/common/CustomTable.dart';
class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: CustomAppBar(title: "Leaderboard",onBackArrowTap: (){
      Navigator.pop(context);
    },),
    body: Padding(
      padding: EdgeInsets.all(10.h),
      child: Column(children: [
        logo(),
        textInfo(),
        SizedBox(height: 20.h,),
        Expanded(
          child: CustomTable(height: MediaQuery.of(context).size.height/2.7, columnHeaders: const ["Rank","Name","","Price"],
              dataKeywords: const [],
              data: List.filled(20, {})),
        )
      ],),
    ),));
  }

  Widget textInfo(){
    return Column(mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(child:
      Text(textAlign: TextAlign.center,style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color: Colors.white30,
            fontSize: 14.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w200,)),
          "Everyday we reward users who are in top place of the leader board with cash prizes. The more you win, the higher you get on the leaderboard.")),
      SizedBox(height: 10.h,),
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Image.asset("images/icons/king.png",height: 50.h,width: 50.h,),
        SizedBox(width: 5.w,),
        Flexible(child: Text(textAlign: TextAlign.center,style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),
            "Winner get Prizes Added to Their\nwallet everyday at midnight 12:00")),
      ],),
      SizedBox(height: 15.h,),
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Text("My Rank Today : ",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),),
        Text("NO RANK",style:GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.green,
              fontSize: 15.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,)))
      ],),
      SizedBox(height: 5.h,),
      Text("** Win Atleast One Game to get you rank",
          style:GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.blue,
                fontSize: 14.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w200,)))
    ],);
  }

  Widget logo(){
    return Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
      child:Image.asset("images/icons/logo.png"),);
  }
}
