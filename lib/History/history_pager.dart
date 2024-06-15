import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ludo_macha/common/CustomTable.dart';

import '../common/CustomAppBar.dart';
class HistoryPager extends StatefulWidget {
  final HistoryEnum choice;
  const HistoryPager({super.key,required this.choice});

  @override
  State<HistoryPager> createState() => _HistoryPagerState();
}

class _HistoryPagerState extends State<HistoryPager> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomAppBar(title: widget.choice.getTitle(),onBackArrowTap: (){
          Navigator.pop(context);
        },),
        body: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(children: [
            logo(),
            SizedBox(height: 10.h,),
            dataList()
          ],),
        ),
      ),
    );
  }

  Widget logo(){
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
          child: Image.asset("images/icons/logo.png")),
        SizedBox(height: 5.h,),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.history_edu),
            SizedBox(width: 4.w,),
            Text(widget.choice.getIconTitle())
          ],)
      ],);
  }

  Widget dataList(){
    double height = MediaQuery.of(context).size.height/1.8;
    switch(widget.choice){
      case HistoryEnum.games:
        return Expanded(
          child: CustomTable(height: height,
              columnHeaders: ["ID","Winner","","Amount"], data: List.filled(20, {"":""})),
        );
      case HistoryEnum.referrals:
        return Expanded(
          child: CustomTable(height: height,
              columnHeaders: ["User ID","Name","","Date"], data: List.filled(20, {"":""})),
        );
      case HistoryEnum.transactions:
        return Expanded(
          child: CustomTable(height: height,
              columnHeaders: ["ID","Date","","Amount"], data: List.filled(20, {})),
        );
    }
  }
}


enum HistoryEnum{
  games,transactions,referrals
}

extension on HistoryEnum{
  String getTitle(){
    switch(this){
      case HistoryEnum.games:
        return "Game History";
      case HistoryEnum.transactions:
        return "Transaction History";
      case HistoryEnum.referrals:
        return "Referrals History";
    }
  }

  String getDefaultText() {
    switch (this) {
      case HistoryEnum.games:
        return "You Haven't Played Any Games Yet";
      case HistoryEnum.transactions:
        return "You have no transactions yet";
      case HistoryEnum.referrals:
        return "No History Available";
    }
  }

    String getIconTitle(){
      switch (this) {
        case HistoryEnum.games:
          return "Recent 20 Games";
        case HistoryEnum.transactions:
          return "Recent 20 Transactions";
        case HistoryEnum.referrals:
          return "Recent 20 Referrals";
      }
    }
}