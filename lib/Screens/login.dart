
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/blocs/login/login_bloc.dart';
import 'package:ludo_macha/blocs/login/login_bloc_events.dart';
import 'package:ludo_macha/blocs/login/login_bloc_states.dart';
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
  ValueNotifier<bool> showLoader = ValueNotifier(false);
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
      create: (context) => LoginRepository(),
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
        if(state.state==LoginStates.finish){
          Navigator.pushReplacementNamed(context, "/dashboard");
          return;
        }
        showLoader.value = false;
        errorDialog((state as ErrorState).message, context);
      },
      listenWhen: (prev,curr){
        return curr.state==LoginStates.error || curr.state==LoginStates.finish;
      },
      builder: (context,state){
        _bloc = context.read<LoginBloc>();
        switch(state.state){
          case LoginStates.phone:
            return phoneNumberContent();
          case LoginStates.otp:
            OTPState s = state as OTPState;
            return otpContent(s.phone,s.id);
          case LoginStates.name:
            NameState s = state as NameState;
            return nameContent(s.phone,s.otp,s.id);
          default:
            return Container();
        }
      },
      buildWhen: (prev,curr){
        return curr.state!=LoginStates.error && curr.state!=LoginStates.finish;
      },
    );
  }
  
  Widget phoneNumberContent(){
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
        canRequestFocus: true,
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
          String phone = phoneController.text.trim();
          if(phone.length<10){
            errorDialog("Invalid phone number",context);
            return;
          }
          showLoader.value = true;
          _bloc.add(SwitchToOTPEvent(phone));
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
            loader()
        ],))
      ],),
    );
  }


  Widget otpContent(String number,String id){
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
          canRequestFocus: true,
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
          FocusManager.instance.primaryFocus?.unfocus();
          String otp = otpController.text;
          if(otp.trim().length<6) {
            errorDialog("Otp not valid", context);
            return;
          }
          _bloc.add(SwitchToNameEvent(number, otp,id));
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
            loader()
          ],))
      ],),
    );
  }
  
  Widget nameContent(String phone,String otp,String id){
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
        TextField(controller: nameController,
          canRequestFocus: true,
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
          String name = nameController.text.trim();
          if(name.isEmpty){
            errorDialog("Valid name required", context);
            return;
          }
          _bloc.add(SignupEvent(phone,otp,id,name));
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
            loader()
          ],))
      ],),
    );
  }


  Widget loader(){
    return ValueListenableBuilder(
      builder: (BuildContext context,bool val,idk){
        return Visibility(visible: val,child: SizedBox(width: 10.w,
        height: 10.h
        ,child: const CircularProgressIndicator(color: Colors.white,)));
      }, valueListenable: showLoader,
    );
  }

}
