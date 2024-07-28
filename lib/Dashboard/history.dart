import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/History/history_pager.dart';
import 'package:ludo_macha/Screens/dashboard.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';

import '../History/history_enum.dart';
class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(backgroundColor: Colors.black,appBar:
    CustomAppBar(title:"History",onBackArrowTap: (){
      DashboardState.pageJumper.add(0);
    },),
    body: Column(children: [
      logo(),
      SizedBox(height: 10.h,),
      options()
    ],),));
  }

  Widget logo(){
    return Column(mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
        child: Image.asset("images/icons/logo.png")),
      SizedBox(height: 5.h,),
      Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.history_edu),
        SizedBox(width: 4.w,),
        const Text("History")
      ],)
    ],);
  }

  Widget options(){
    return ListTileTheme(tileColor: Colors.white12.withOpacity(0.1),
      dense: true,
      child: Column(children: [
        gamesOption(),
        SizedBox(height: 3.h,),
        transOption(),
        SizedBox(height: 3.h,),
        refOption()
      ],),
    );
  }

  Widget gamesOption(){
    return ListTile(leading: Icon(Icons.gamepad,color: Colors.orange,
    size: 30.w,),
    title: Text("Games",style: GoogleFonts.rubik(
        textStyle: TextStyle(
          color: Colors.orange,
          fontSize: 16.sp,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,)),),
      trailing: const Icon(Icons.arrow_forward_ios),
    subtitle: Text("List of recently played games",style: GoogleFonts.rubik(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 13.sp,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300,)),),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const HistoryPager(choice: HistoryEnum.games);
        }));
      },
    );
  }

  Widget transOption(){
    return ListTile(leading: Icon(Icons.attach_money,color:Colors.green,
    size: 30.w,),
      title: Text("Transactions",style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color: Colors.green,
            fontSize: 16.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,)),),
      trailing: const Icon(Icons.arrow_forward_ios),
      subtitle: Text("List of past transactions",
      style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,)),),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const HistoryPager(choice: HistoryEnum.transactions);
        }));
      },
    );
  }

  Widget refOption(){
    return ListTile(leading: Icon(Icons.people_alt_outlined,color:Colors.blueAccent,
    size: 30.w,),
      title: Text("Referrals",style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color: Colors.blue,
            fontSize: 16.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,)),),
      trailing: const Icon(Icons.arrow_forward_ios),
      subtitle: Text("Referrals joined under you",style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,)),),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const HistoryPager(choice: HistoryEnum.referrals);
        }));
      },
    );
  }
}
