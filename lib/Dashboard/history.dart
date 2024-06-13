import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ludo_macha/Screens/dashboard.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
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
    CustomAppBar(title:"History"),
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
        child: SvgPicture.asset("images/icons/logo.svg"),),
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
    title: const Text("Games",style: TextStyle(color: Colors.orange),),
      trailing: const Icon(Icons.arrow_forward_ios),
    subtitle: const Text("List of recently played games"),
    );
  }

  Widget transOption(){
    return ListTile(leading: Icon(Icons.attach_money,color:Colors.green,
    size: 30.w,),
      title: const Text("Transactions",style: TextStyle(color: Colors.green),),
      trailing: const Icon(Icons.arrow_forward_ios),
      subtitle: const Text("List of past transactions"),
    );
  }

  Widget refOption(){
    return ListTile(leading: Icon(Icons.people_alt_outlined,color:Colors.blueAccent,
    size: 30.w,),
      title: const Text("Referrals",style: TextStyle(color: Colors.blueAccent),),
      trailing: const Icon(Icons.arrow_forward_ios),
      subtitle: const Text("Referrals joined under you"),
    );
  }



}
