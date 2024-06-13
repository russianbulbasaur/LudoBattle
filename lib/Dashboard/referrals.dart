import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';

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
      appBar: CustomAppBar(title: "Referrals",),
    body: Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(children: [
        logo(),
        SizedBox(),
        referralLink(),
        SizedBox(),
        refStats(),
        SizedBox(),
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
        Icon(Icons.link),
        SizedBox(width: 5.w,),
        Text("Referral Link")
      ],),
      SizedBox(height: 10.h,),
      Text("Share this referral link with your friends and earn 1%\ncommission on their earnings"),
      SizedBox(height: 10.h,),
      Container(height: 50.h,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: Colors.white24,width: 1)),
      child: Center(child: Text("https://google.com"),),),
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
                    side: const BorderSide(color: Colors.green,width: 2.3)))), child:
            IconText(icon: Icon(Icons.share,size: 20.w,color: Colors.green,),
              text: "Share Link",
              style: TextStyle(fontSize: 10.sp,
                  fontWeight: FontWeight.bold,color: Colors.green),)),
      ),
      SizedBox(width: 14.w,),
      Expanded(
        child: TextButton(onPressed: (){},
            style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width,40.h)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                    side: const BorderSide(color: Colors.blue,width: 2.3)))), child:
            IconText(icon: Icon(Icons.copy,size: 20.w,color: Colors.blueAccent,),
              text: "Copy Link",
              style: TextStyle(fontSize: 10.sp,
                  fontWeight: FontWeight.bold,color: Colors.white),)),
      )
    ],);
  }


  Widget refStats(){
    return Column(mainAxisSize: MainAxisSize.min,
    children: [],);
  }

  Widget refList(){
    return Column(mainAxisSize: MainAxisSize.min,children: [],);
  }
}
