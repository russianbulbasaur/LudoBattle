import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/Screens/dashboard.dart';
import 'package:ludo_macha/blocs/login/LoginBloc.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
import 'package:ludo_macha/repositories/login/login_repository.dart';

import '../common/IconAndText.dart';
class Referrals extends StatefulWidget {
  const Referrals({super.key});

  @override
  State<Referrals> createState() => _ReferralsState();
}

class _ReferralsState extends State<Referrals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: CustomAppBar(title: "Referrals",onBackArrowTap: (){
        DashboardState.pageJumper.add(2);
      },),
    body: Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(children: [
        logo(),
        const SizedBox(),
        referralLink(),
        const SizedBox(),
        refStats(),
        const SizedBox(),
        refList(),
      ],),
    ),);
  }

  Widget logo(){
    return Container(width: 200.h,height: 200.h,padding: EdgeInsets.all(20.w),
      child: SvgPicture.asset("images/icons/logo.svg"),);
  }

  Widget referralLink(){
    return Column(mainAxisSize: MainAxisSize.min,
    children: [
      Row(children: [
        const Icon(Icons.link),
        SizedBox(width: 5.w,),
        Text("Referral Link",
            style:GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,)))
      ],),
      SizedBox(height: 10.h,),
      Text("Share this referral link with your friends and earn 1%\ncommission on their earnings",
      style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color:Colors.grey.shade500,
            fontSize: 14.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w200,)),),
      SizedBox(height: 10.h,),
      Container(height: 50.h,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: Colors.white24,width: 1)),
      child: Center(child: Text("https://google.com",
      style: GoogleFonts.rubik(
          textStyle: TextStyle(
            color:Colors.white,
            fontSize: 18.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,)),),),),
      SizedBox(height: 10.h,),
      buttons()
    ],);
  }

  Widget buttons(){
    return  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
      Expanded(
        child: TextButton(onPressed: (){},
            style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                    side: const BorderSide(color: Color(0xff2AE716),width: 2.3)))), child:
            IconText(icon: Icon(Icons.share,size: 20.w,color: const Color(0xff2AE716),),
              text: "Share Link",
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color:const Color(0xff2AE716),
                    fontSize: 13.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,)),)),
      ),
      SizedBox(width: 14.w,),
      Expanded(
        child: TextButton(onPressed: (){},
            style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                    side: const BorderSide(color: Color(0xff01A4F5),width: 2.3)))), child:
            IconText(icon: Icon(Icons.copy,size: 20.w,color: const Color(0xff01A4F5),),
              text: "Copy Link",
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    color: const Color(0xff01A4F5),
                    fontSize: 13.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,)),)),
      )
    ],);
  }


  Widget refStats(){
    return Column(mainAxisSize: MainAxisSize.min,
    children: [
      Row(children: [
        const Icon(Icons.area_chart,color: Colors.white,),
        SizedBox(width: 5.w,),
        Text("My Referral Statistics",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,)),)
      ],),
      SizedBox(height:10.h),
      Container(decoration: const BoxDecoration(),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Column(children: [
          const Text("0"),
          SizedBox(height: 5.h,),
          Text("Total\nReferrrals",style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,)),)
        ],),
          const Divider(),
          Column(children: [
            TextIcon(text: "0", icon: const Icon(Icons.currency_rupee)),
            SizedBox(height: 5.h,),
            Text("Total\nRef Income",
                style:GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,)))
          ],),
          const Divider(),
          Column(children: [
            TextIcon(text: "0", icon: const Icon(Icons.currency_rupee)),
            SizedBox(height: 5.h,),
            Text("Today\nRef Income",style:  GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,)),)
          ],),
      ],),)
    ],);
  }

  Widget refList(){
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          const Icon(Icons.area_chart),
          SizedBox(width: 5.w,),
          Text("My Top Earning Referrals List",style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,)),)
        ],),
        SizedBox(height:10.h),
        Text("List of your top earning referrals",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color:Colors.grey.shade500,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w200,)),),
        (false)?Table():const Text("No data available")
      ],);
  }
}
