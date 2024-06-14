import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void errorDialog(String text,BuildContext context){
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