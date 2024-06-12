import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CustomRouter.dart';
import 'login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        colorScheme: const ColorScheme.dark()
      ),
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: "/login",
    );
  }

}