import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
import 'package:ludo_macha/common/IconAndText.dart';

import '../common/ErrorDialog.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  List<String> dummy = ["","",""];
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(floatingActionButton:
      rankFab(),appBar: CustomAppBar(title: "Play Game",onBackArrowTap: (){
      Navigator.pop(context);
    },),body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(children: [
          adPager(),
          SizedBox(height: 10.h,),
          host(),
          SizedBox(height: 10.h,),
          openChallenges(),
          SizedBox(height: 10.h,),
          liveChallenges()
        ],),
      ),
    ),));
  }

  Widget adPager(){
    return SizedBox(height: 80.h,
      child: PageView(children: [
        Container(color: Colors.blue,),
        Container(color: Colors.red,),
        Container(color: Colors.yellowAccent,)
      ],),
    );
  }

  Widget openChallenges(){ 
    return Column(mainAxisSize: MainAxisSize.min,
    children: [
      Container(height: 46.h,decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white10
      ),padding: EdgeInsets.all(10.w),
      child: Row(children: [
        SizedBox(width: 10.w,),
        const Icon(Icons.arrow_forward_rounded,color: Colors.green,),
        SizedBox(width: 3.w,),
        Text("Open challenges",style: GoogleFonts.rubik(
          color: Colors.green
        ),),
        const Spacer(),
        TextButton(onPressed: (){dummy.removeLast();
          setState(() {

          });},style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white10),shape:
        WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),),
          child: IconText(icon:  Icon(Icons.refresh,size: 15.w,color: Colors.white,),
        text: "Reload",style: GoogleFonts.rubik(color: Colors.white)),),
        SizedBox(width: 10.w,)
      ],),),
      SizedBox(height: 10.h,),
      Column(mainAxisSize: MainAxisSize.min,
      children: dummy.map((e){
        return Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: openChallengeTile(e),
        );
      }).toList(),)
    ],);
  }
  
  Widget openChallengeTile(String e){
    return Container(height: 60.h,decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.black45
    ),padding: EdgeInsets.all(10.w),
      child: Row(children: [
        SizedBox(width: 10.w,),
        IconText(icon: Icon(Icons.currency_rupee,color:Color(0xff2AE716)), text: "50",style:
          GoogleFonts.rubik(color: Color(0xff2AE716)),),
        SizedBox(width: 10.w,),
        Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            CircleAvatar(backgroundColor: Colors.blue,child:
            Center(child: Icon(Icons.person,size:15.sp,),),
            radius: 10.sp,),
            SizedBox(width: 3.w,),
            Text("Ankit",style: GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),)
          ],),
          SizedBox(height: 4.h,),
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            Text("Winning : ",style: GoogleFonts.rubik(color: Colors.white30,),),
            IconText(icon: Icon(Icons.currency_rupee,color: Colors.orange,size: 9.sp,), text: "90",
              style: GoogleFonts.rubik(fontSize: 10.sp,color: Colors.orange),)
          ],)
        ],),
        Spacer(),
        TextButton(onPressed: (){},style: ButtonStyle(backgroundColor:
        WidgetStateProperty.all(Colors.lightBlue),shape:
        WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),),
          child: Text("\t\t\tAccept\t\t\t",style: GoogleFonts.rubik(color: Colors.white)))
      ],),);
  }

  Widget liveChallenges(){
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 46.h,decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white10
        ),padding: EdgeInsets.all(10.w),
          child: Row(children: [
            SizedBox(width: 10.w,),
            const Icon(Icons.arrow_forward_rounded,color: Colors.blue,),
            SizedBox(width: 3.w,),
            Text("Live challenges",style: GoogleFonts.rubik(
                color: Colors.blue
            ),),
          ],),),
        SizedBox(height: 10.h,),
        Column(mainAxisSize: MainAxisSize.min,
          children: dummy.map((e){
            return Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: liveChallengeTile(e),
            );
          }).toList(),)
      ],);
  }

  Widget liveChallengeTile(String e){
    return Container(height: 30.h,decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.black45
    ),padding: EdgeInsets.all(10.w),
      child: Row(children: [
        SizedBox(width: 10.w,),
        IconText(icon: Icon(Icons.currency_rupee,color:Colors.blue), text: "50",style:
        GoogleFonts.rubik(color: Colors.blue),),
        SizedBox(width: 10.w,),
        Text("Rahul VS Ankit",style: GoogleFonts.rubik(
          fontWeight: FontWeight.bold,
          color: Colors.white70
        ),)
      ],),);
  }

  Widget host(){
    return SizedBox(height: 40.h,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Expanded(flex: 1,
          child: SizedBox(height: 32.h,
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: amountController,
              maxLength: 10,
              decoration: InputDecoration(
                  isDense: true,
                  counterText: "",border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.black12,width: 1.w)
              ),hintText: "Amount",focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.blue,width: 1.w)
              )),),
          ),
        ),
        SizedBox(width: 10.w,),
        Expanded(flex: 1,
          child: TextButton(style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(10.r)))
          ),onPressed: (){
            dummy.add("");
            setState(() {

            });
            if(amountController.text.trim().isEmpty){
              //errorDialog("Invalid amount",context);
              return;
            }
          }, child:
            IconText(icon: const Icon(Icons.gamepad,color: Colors.white,),text: "Host Game",style:
            GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,)),)),
        )
      ],),
    );
  }

  Widget rankFab(){
    return GestureDetector(onTap: (){
      Navigator.pushNamed(context, "/leaderboard");
    },child: FloatingActionButton(onPressed: (){},shape: const CircleBorder(),
      child:
      Container(decoration: BoxDecoration(shape: BoxShape.circle,
      border: Border.all(width: 1.h,color: Colors.yellowAccent),color: Colors.green),
      child: const Center(child: Text("No\nRank",textAlign: TextAlign.center,),),),));
  }
}
