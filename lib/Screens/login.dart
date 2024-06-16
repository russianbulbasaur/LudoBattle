
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/blocs/login/LoginBloc.dart';
import 'package:ludo_macha/blocs/login/LoginBlocEvents.dart';
import 'package:ludo_macha/blocs/login/LoginBlocStates.dart';
import 'package:ludo_macha/repositories/login/login_repository.dart';

import '../common/ErrorDialog.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginBlocState previous;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late LoginBloc _bloc;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo(),
          infoBox()
        ],
      ),
    ));
  }

  Widget logo(){
    return  Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
      child: Image.asset("images/icons/logo.png"),);
  }

  Widget infoBox(){
    return RepositoryProvider(
      create: (context) => LoginRepository(context),
      child: BlocProvider(
        create: (context) => LoginBloc(context.read<LoginRepository>()),
        child: SizedBox(width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: infoBoxContent(),
        ),),
      ),
    );
  }

  Widget infoBoxContent(){
    return BlocConsumer<LoginBloc,LoginBlocState>(
      listener: (context,state){
        if(state.enumState==LoginState.finish){
          Navigator.pushReplacementNamed(context, "/dashboard");
          return;
        }
        errorDialog((state as ErrorState).text,context);
      },
      listenWhen: (prev,curr){
        return curr.enumState==LoginState.errorState || curr.enumState==LoginState.finish;
      },
      builder: (context,state){
        _bloc = context.read<LoginBloc>();
        switch(state.enumState){
          case LoginState.sendingOTP:
          case LoginState.phone:
            return phoneNumberContent(state.showLoader);
          case LoginState.verifyingOTP:  
          case LoginState.otp:
            return otpContent(state.showLoader,"");
          case LoginState.uploadingName:  
          case LoginState.name:
            return nameContent(state.showLoader);
          default:
            return Container();
        }
      },
      buildWhen: (prev,curr){
        return curr.enumState!=LoginState.errorState;
        },
    );
  }
  
  Widget phoneNumberContent(bool showLoader){
    return Container(decoration: const BoxDecoration(color: Colors.black26),
      padding: EdgeInsets.all(10.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text("Enter phone number",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),textAlign: TextAlign.start,),
        SizedBox(height: 4.h,),
        Text("We will send a otp to this number",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white30,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w200,)),),
        SizedBox(height: 10.h,),
        TextField(keyboardType: TextInputType.phone,
          controller: phoneController,
        maxLength: 10,
        decoration: InputDecoration(counterText: "",
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.black12,width: 1.w)
        ),hintText: "Enter Mobile Number",focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: Colors.blue,width: 1.w)
        )),),
        SizedBox(height: 10.h,),
        TextButton(style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0),),
          backgroundColor: WidgetStateProperty.all(Colors.blue),
        ),onPressed: (){
          if(phoneController.text.trim().length<10){
            errorDialog("Invalid phone number",context);
            return;
          }
          _bloc.add(OtpRequestedEvent(phoneController.text,_bloc));
        }, child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Icon(Icons.send,color: Colors.white,),
          SizedBox(width: 5.w),
          Text("Send",style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,)),),
            SizedBox(width: 10.w,),
            Visibility(visible: showLoader,child: SizedBox(width: 10.w,
            height: 10.h
            ,child: const CircularProgressIndicator(color: Colors.white,)))
        ],))
      ],),
    );
  }


  Widget otpContent(bool showLoader,number){
    return Container(decoration: const BoxDecoration(color: Colors.black26),
      padding: EdgeInsets.all(10.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text("Enter the otp",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),textAlign: TextAlign.start,),
        SizedBox(height: 4.h,),
        Text("We have sent an otp to --------",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white30,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w200,)),),
        SizedBox(height: 10.h,),
        TextField(maxLength: 6,controller: otpController,
          decoration: InputDecoration(counterText: "",border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.black12,width: 1.w)
          ),hintText: "Enter OTP",focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.green,width: 1.w)
          )),keyboardType: TextInputType.phone,),
        SizedBox(height: 10.h,),
        TextButton(style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0),),
          backgroundColor: WidgetStateProperty.all(Colors.green),
        ),onPressed: (){
          String otp = otpController.text;
          if(otp.trim().length<6) return;
          _bloc.add(OtpVerificationEvent(otp));
        }, child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user_sharp,color: Colors.white,),
            SizedBox(width: 5.w),
            Text("Verify",style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,)),),
            SizedBox(width: 10.w,),
            Visibility(visible: showLoader,child: SizedBox(width: 10.w,
                height: 10.h
                ,child: const CircularProgressIndicator(color: Colors.white,)))
          ],))
      ],),
    );
  }
  
  Widget nameContent(bool showLoader){
    return Container(decoration: const BoxDecoration(color: Colors.black26),
      padding: EdgeInsets.all(10.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text("Enter a nickname",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),textAlign: TextAlign.start,),
        SizedBox(height: 4.h,),
        Text("What should we call you?",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white30,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w200,)),),
        SizedBox(height: 10.h,),
        TextField(keyboardType: TextInputType.text,controller: nameController,
          decoration: InputDecoration(border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.black12,width: 1.w)
          ),hintText: "Name",focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.orange,width: 1.w)
          )),),
        SizedBox(height: 10.h,),
        TextButton(style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0),),
          backgroundColor: WidgetStateProperty.all(Colors.orange),
        ),onPressed: (){
          if(nameController.text.trim().isEmpty) return;
          _bloc.add(NameUploadEvent(nameController.text.trim()));
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
            Visibility(visible: showLoader,child: SizedBox(width: 10.w,
                height: 10.h
                ,child: const CircularProgressIndicator(color: Colors.white,)))
          ],))
      ],),
    );
  }

}
