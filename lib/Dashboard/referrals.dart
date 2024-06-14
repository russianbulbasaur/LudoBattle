import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/Screens/dashboard.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
import 'package:share_plus/share_plus.dart';

import '../common/IconAndText.dart';
class Referrals extends StatefulWidget {
  const Referrals({super.key});

  @override
  State<Referrals> createState() => _ReferralsState();
}

class _ReferralsState extends State<Referrals> {

  String refLink = "Random stuff";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.black,
        appBar: CustomAppBar(title: "Referrals",onBackArrowTap: (){
          DashboardState.pageJumper.add(0);
        },),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(children: [
            logo(),
            const SizedBox(),
            referralLink(),
            SizedBox(height: 30.h,),
            refStats(),
            SizedBox(height:30.h),
            refList(),
            SizedBox(height: 30.h,)
          ],),
        ),
      ),),
    );
  }

  Widget logo(){
    return Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
      child: Image.asset("images/icons/logo.png"),);
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
        child: TextButton(onPressed: (){
          Share.share(refLink);
        },
            style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
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
        child: TextButton(onPressed: (){
          Clipboard.setData(ClipboardData(text: refLink));
        },
            style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
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
      Container(decoration: BoxDecoration(
          border: Border.all(color:  const Color(0xff282B2E),width: 1.w),
          borderRadius: BorderRadius.circular(9.86.r)
      ),padding: EdgeInsets.all(14.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Column(children: [
          const Text("0"),
          SizedBox(height: 5.h,),
          Text("Total\nReferrals",style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,)),textAlign: TextAlign.center,)
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
                      fontWeight: FontWeight.w300,)),textAlign: TextAlign.center,)
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
                  fontWeight: FontWeight.w300,)),textAlign: TextAlign.center)
          ],),
      ],),)
    ],);
  }

  Widget refList(){
    return Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start,children: [
          const Icon(Icons.area_chart),
          SizedBox(width: 5.w,),
          Text("My Top Earning Referrals List",style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,)),textAlign: TextAlign.center)
        ],),
        SizedBox(height:5.h),
        Text("List of your top earning referrals",textAlign: TextAlign.start,
          style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color:Colors.grey.shade500,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w200,)),),
        SizedBox(height:20.h),
        Center(child: (false)?Table():const Text("No data available"))
      ],);
  }
}
