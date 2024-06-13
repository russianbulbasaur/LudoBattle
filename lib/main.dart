import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CustomRouter.dart';
import 'Screens/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(Duration(milliseconds: 1000));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child){
        return MaterialApp(
          theme: ThemeData(
              useMaterial3: true,
              textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
              buttonTheme: ButtonThemeData(shape:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              colorScheme: ColorScheme.dark()
          ),
          onGenerateRoute: CustomRouter.generateRoute,
          initialRoute: "/loginss",
        );
      },
    );
  }

}