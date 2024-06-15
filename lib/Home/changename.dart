import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';

import '../common/IconAndText.dart';
class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: CustomAppBar(onBackArrowTap: (){
      Navigator.pop(context);
    },
    title: "Change Name",),
    body: Column(children: [
      logo(),
      changeNameBox(),
      SizedBox(height: 10.h,),
      saveButton()
    ],),));
  }

  Widget logo(){
    return Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
      child:Image.asset("images/icons/logo.png"),);
  }

  Widget changeNameBox(){
    return Container(decoration: const BoxDecoration(color: Colors.black26),
      padding: EdgeInsets.all(10.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text("Enter New Nick Name",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),textAlign: TextAlign.start,),
        SizedBox(height: 4.h,),
        Text("Your New nickname will be updated as reflected to all users.",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white30,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w200,)),),
        SizedBox(height: 10.h,),
        TextField(keyboardType: TextInputType.phone,
          controller: nameController,
          maxLength: 10,
          decoration: InputDecoration(counterText: "",border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.black12,width: 1.w)
          ),hintText: "Ankit",focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.blue,width: 1.w)
          )),),
        SizedBox(height: 10.h,),
      ],),
    );
  }

  Widget saveButton(){return  Padding(
    padding: EdgeInsets.only(left: 5.w,right: 5.w),
    child: TextButton(onPressed: (){

    },
        style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,47.h)),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),
                side: const BorderSide(color: Colors.blue,width: 2.3)))), child:
        IconText(icon: Icon(Icons.save,color: Colors.blue,size: 23.h,),
          text: "Save Name",
          style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,)),)),
  );}

}
