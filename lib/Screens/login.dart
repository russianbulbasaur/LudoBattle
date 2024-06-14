import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/blocs/login/LoginBloc.dart';
import 'package:ludo_macha/blocs/login/LoginBlocEvents.dart';
import 'package:ludo_macha/blocs/login/LoginBlocStates.dart';
import 'package:ludo_macha/repositories/login/login_repository.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        errorDialog((state as ErrorState).text);
      },
      listenWhen: (prev,curr){
        return curr.enumState==LoginState.errorState;
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
    return Container(decoration: BoxDecoration(color: Colors.black26),
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
        decoration: InputDecoration(border: OutlineInputBorder(
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
          if(phoneController.text.trim().isEmpty) return;
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
            ,child: CircularProgressIndicator(color: Colors.white,)))
        ],))
      ],),
    );
  }


  Widget otpContent(bool showLoader,number){
    return Container(decoration: BoxDecoration(color: Colors.black26),
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
        TextField(controller: otpController,
          decoration: InputDecoration(border: OutlineInputBorder(
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
                ,child: CircularProgressIndicator(color: Colors.white,)))
          ],))
      ],),
    );
  }
  
  Widget nameContent(bool showLoader){
    return Container(decoration: BoxDecoration(color: Colors.black26),
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
        TextField(controller: nameController,
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
          if(phoneController.text.trim().isEmpty) return;
          _bloc.add(OtpRequestedEvent(phoneController.text,_bloc));
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
                ,child: CircularProgressIndicator(color: Colors.white,)))
          ],))
      ],),
    );
  }
  
  void errorDialog(String text){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.white,content: Column(mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(text,style:GoogleFonts.rubik(
          color: Colors.red,
            fontWeight: FontWeight.w500
        )),
        TextButton(onPressed: (){
          Navigator.pop(context);
        },style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.black45)),child: Text("OK",style: GoogleFonts.rubik(
          color: Colors.red,
          fontWeight: FontWeight.bold
        ),))
      ],),);
    });
  }

}
