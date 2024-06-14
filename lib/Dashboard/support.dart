import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';

import '../Screens/dashboard.dart';
class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomAppBar(title: "Support",onBackArrowTap: (){
          DashboardState.pageJumper.add(3);
        },),
        body: supportBody(),
      ),
    );
  }

  Widget supportBody(){
    return Column(children: [
      logo(),
      Divider(),
      supportText(),
      Divider(),
      contactButton()
    ],);
  }

  Widget logo(){
    return Container(width: 200.h,height: 200.h,padding: EdgeInsets.all(20.w),
    child: SvgPicture.asset("images/icons/logo.svg"),);
  }

  Widget supportText(){
    return Container(padding: EdgeInsets.only(top: 10.h,bottom: 10.h,
    left: 10.w,right: 10.w),child: Column(children: [
      Row(children: [
        Icon(Icons.speed),
        SizedBox(width: 5.w,),
        Text("Customer Support",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,)),)
      ],),
      SizedBox(height : 10.h),
      Text("Create A Support Ticket, if you have a problem with a game,\ndeposit or withdrawal. Our team will get back to you ASAP.",
      style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color:Colors.grey.shade500,
            fontSize: 12.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w200,)),),
      SizedBox(height: 10.h,)
    ],),);
  }

  Widget contactButton(){
    return Container(height: 80.h,padding: EdgeInsets.all(10.w),
    child: Column(children: [
      Expanded(
        child: TextButton(onPressed: (){},
            style: ButtonStyle(fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide(color: Colors.green,width: 2.3)))), child: Text("Contact Support",
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 13.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,)),)),
      ),
      SizedBox(height: 5.h,),
      const Text("We will get back to you ASAP.")
    ],),);
  }
}
