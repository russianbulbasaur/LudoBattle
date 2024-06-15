import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/CustomAppBar.dart';
import '../common/ErrorDialog.dart';
class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {

  TextEditingController amountController = TextEditingController();
  TextEditingController upiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: CustomAppBar(title: "Withdraw",onBackArrowTap: (){
      Navigator.pop(context);
    },),body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(children: [
          logo(),
          amountBoxes(),
          SizedBox(height: 10.h,),
          amountAndUpi(),
          SizedBox(height: 10.h,),
          withdrawButton(),
          SizedBox(height: 30.h,)
        ],),
      ),
    ),));
  }

  Widget logo(){
    return Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
      child:Image.asset("images/icons/logo.png"),);
  }

  Widget amountAndUpi(){
    return Container(decoration: const BoxDecoration(color: Colors.black26),
      padding: EdgeInsets.all(10.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text("Enter Amount to Withdraw",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),textAlign: TextAlign.start,),
        SizedBox(height: 4.h,),
        Text("Minimum Deposit Amount is 90. Please enter the upi along with the amount.",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white30,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w200,)),),
        SizedBox(height: 10.h,),
        TextField(keyboardType: TextInputType.phone,
          controller: amountController,
          maxLength: 10,
          decoration: InputDecoration(counterText: "",border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.black12,width: 1.w)
          ),hintText: "Amount",focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.pinkAccent,width: 1.w)
          )),),
        SizedBox(height: 10.h,),
        TextField(
          controller: upiController,
          maxLength: 10,
          decoration: InputDecoration(counterText: "",border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.black12,width: 1.w)
          ),hintText: "Enter UPI Id",focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.pinkAccent,width: 1.w)
          )),)
      ],),
    );
  }


  Widget withdrawButton(){
    return   TextButton(style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0),),
      backgroundColor: WidgetStateProperty.all(Colors.pinkAccent),
    ),onPressed: (){
      if(amountController.text.trim().isEmpty){
        errorDialog("Invalid amount",context);
        return;
      }
    }, child:
    Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.monetization_on_rounded,color: Colors.white,),
        SizedBox(width: 5.w),
        Text("Withdraw",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),),
        SizedBox(width: 10.w,),
        Visibility(visible: false,child: SizedBox(width: 10.w,
            height: 10.h
            ,child: const CircularProgressIndicator(color: Colors.white,)))
      ],));
  }

  Widget amountBoxes() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
      Expanded(flex: 1,child: Container(height: 70.h,decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r)
      ),
        child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,children: [
          const Text("Deposit"),
          SizedBox(height: 4.h,),
          Text("0.00",style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,)),)
        ],),),
      ),),
      SizedBox(width: 4.w,),
      Expanded(flex: 1,child: Container(height:70.h,decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.r)
      ),
        child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,children: [
          const Text("Withdrawable"),
          SizedBox(height: 4.h,),
          Text("10.00",style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,)),)
        ],),),
      ),)
    ],);
  }



}
