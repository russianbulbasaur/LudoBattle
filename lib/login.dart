import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_macha/blocs/login/LoginBloc.dart';
import 'package:ludo_macha/blocs/login/LoginBlocEvents.dart';
import 'package:ludo_macha/blocs/login/LoginBlocStates.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController fieldController = TextEditingController();
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
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: SizedBox(width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: infoBoxContent(),
      ),),
    );
  }

  Widget infoBoxContent(){
    return BlocConsumer<LoginBloc,LoginBlocState>(
      listener: (context,state){
      },
      builder: (context,state){
        return Column(children: [
          Text(state.heading),
          Text(state.text),
          TextField(controller: fieldController,),
          TextButton(onPressed: (){
            context.read<LoginBloc>().add(OtpRequestedEvent(fieldController.text));
          },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(state.primary),), child:
          Row(children: [
            Icon(state.buttonIcon),
            Text(state.buttonText)
          ],))
        ],);
      }
    );
  }

}
