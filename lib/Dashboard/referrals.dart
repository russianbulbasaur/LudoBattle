import 'package:flutter/material.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
class Referrals extends StatefulWidget {
  const Referrals({super.key});

  @override
  State<Referrals> createState() => _ReferralsState();
}

class _ReferralsState extends State<Referrals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amber,appBar: CustomAppBar(title: "Referrals",),);
  }
}
