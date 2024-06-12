import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Container();
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
    return Column(children: [
      Text("Enter phone number"),
      Text("We will send a otp to this number"),
      TextField(controller: phoneController,),
      TextButton(onPressed: (){
        if(phoneController.text.trim().isEmpty) return;
        _bloc.add(OtpRequestedEvent(phoneController.text,_bloc));
      }, child:
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(Icons.send),
        Text("Send")
      ],))
    ],);
  }
  
  Widget otpContent(bool showLoader,number){
    return Column(children: [
      Text("Enter otp"),
      Text("Enter the otp sent to "+number),
      TextField(controller: otpController,),
      TextButton(onPressed: (){
        
      },
          child:
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Icon(Icons.lock),
        Text("Verify")
      ],))
    ],);
  }
  
  Widget nameContent(bool showLoader){
    return Column(children: [
      Text("What should we call you?"),
      Text("Enter a nickname"),
      TextField(controller: nameController,),
      TextButton(onPressed: (){
     
      }, child:
      Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Icon(Icons.save),
        Text("Save")
      ],))
    ],);
  }
  
  void errorDialog(String text){
    showDialog(context: context, builder: (context){
      return AlertDialog(content: Column(children: [
        Text(text),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("OK"))
      ],),);
    });
  }

}
