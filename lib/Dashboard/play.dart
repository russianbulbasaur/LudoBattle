import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(backgroundColor: Colors.lightGreen,));
  }
}
