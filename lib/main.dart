import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CustomRouter.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        buttonTheme: ButtonThemeData(shape:
        OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: "/login",
    );
  }

}