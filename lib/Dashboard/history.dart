import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ludo_macha/Screens/dashboard.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: CustomAppBar(title:"History")
    ,backgroundColor: Colors.blue,));
  }
}
