import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';

import '../Models/Game.dart';
import '../common/IconAndText.dart';
class ViewGame extends StatefulWidget {
  final Game game;
  const ViewGame({super.key,required this.game});

  @override
  State<ViewGame> createState() => _ViewGameState();
}

class _ViewGameState extends State<ViewGame> {
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: CustomAppBar(onBackArrowTap: (){
      Navigator.pop(context);
    },
    title: "View Game",),
    body: Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(children: [
        gameStats(),
        SizedBox(height: 10.h,),
        (widget.game.type==GameType.host)?codeAreaHost():codeAreaPlayer()
      ],),
    ),));
  }

  Widget gameStats(){
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),
    border: Border.all(color: Colors.white10,width: 1.w)),
    child: Column(mainAxisSize: MainAxisSize.min,children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Text("Players : "),
          Text("${widget.game.player2} VS ${widget.game.player1}")
        ],),
      ),
      Divider(thickness: 1.h,color: Colors.white10,),
      Padding(
        padding: EdgeInsets.only(left: 40.w,right: 120.w,top: 10.h),
        child: SizedBox(height: MediaQuery.of(context).size.height/7,
          child: Column(children: [
            Row(children: [
              Column(mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.min,children: [
                Text("Game ID"),
                SizedBox(height: 3.h,),
                Text("#55555")
              ],),
              Spacer(),
              Column(mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.min,children: [
                Text("Game ID"),
                SizedBox(height: 3.h,),
                Text("#55555")
              ],)
            ],),
            SizedBox(height: 20.h,),
            Row(children: [
              Column(mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.min,children: [
                Text("Game ID"),
                SizedBox(height: 3.h,),
                Text("#55555")
              ],),
              Spacer(),
              Column(mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.min,children: [
                Text("Game ID"),
                SizedBox(height: 3.h,),
                Text("#55555")
              ],)
            ],)
          ],)
        ),
      )
    ],),);
  }

  Widget codeAreaPlayer(){
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.white10,width: 1.w)),
      child: Column(mainAxisSize: MainAxisSize.min,children: [
        Row(children: [Text("You are "),Text("Player")],mainAxisAlignment: MainAxisAlignment.center,),
        Text(textAlign: TextAlign.center,
            "Join the room code shared here. The code will be copied to your clipboard after you click on the button below"),
        SizedBox(height: 10.h,),
        Text("CSDFSDFSDCDC"),
        SizedBox(height: 10.h,),
        TextButton(style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0),),
          backgroundColor: WidgetStateProperty.all(Colors.orange),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(10.r)))
        ),onPressed: (){

        }, child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.copy,color: Colors.white,),
            SizedBox(width: 5.w),
            Text("Copy & Open Ludo King",style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,)),),
            SizedBox(width: 10.w,),
            Visibility(visible: false,child: SizedBox(width: 10.w,
                height: 10.h
                ,child: const CircularProgressIndicator(color: Colors.white,)))
          ],)),
        SizedBox(height: 5.h,),
      ],),);
  }

  Widget codeAreaHost(){
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.white10,width: 1.w)),
      child: Column(mainAxisSize: MainAxisSize.min,children: [
        Row(children: [Text("You are "),Text("Host")],mainAxisAlignment: MainAxisAlignment.center,),
        Text("Open Ludo King App to create the Room and share the 8 digit room code here",
        textAlign: TextAlign.center,),
        SizedBox(height: 10.h,),
        TextField(controller: codeController,
          decoration: InputDecoration(border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.black12,width: 1.w)
          ),hintText: "Code",focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.orange,width: 1.w)
          )),),
        SizedBox(height: 10.h,),
        TextButton(style: ButtonStyle(minimumSize:
        WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0),),
          backgroundColor: WidgetStateProperty.all(Colors.orange),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(10.r)))
        ),onPressed: (){
          if(codeController.text.trim().isEmpty) return;

        }, child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.save,color: Colors.white,),
            SizedBox(width: 5.w),
            Text("Save",style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,)),),
            SizedBox(width: 10.w,),
            Visibility(visible: false,child: SizedBox(width: 10.w,
                height: 10.h
                ,child: const CircularProgressIndicator(color: Colors.white,)))
          ],)),
        SizedBox(height: 5.h,),
        TextButton(style: ButtonStyle(minimumSize:

        WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0)),
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(10.r)))
        ),onPressed: (){
        }, child:
        IconText(icon: const Icon(Icons.open_in_browser,
          color: Colors.white,),text: "Open Ludo King",style:
        GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),))
      ],),);
  }
}
