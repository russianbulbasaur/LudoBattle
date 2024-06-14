import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ludo_macha/blocs/login/LoginBloc.dart';
import 'package:ludo_macha/blocs/login/LoginBlocStates.dart';
import 'package:ludo_macha/repositories/login/login_repository.dart';

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
        body: Column(children: [
          logo(),
          SizedBox(height: 10.h,),
          dataList()
        ],),
      ),
    );
  }

  Widget logo(){
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
          child: SvgPicture.asset("images/icons/logo.svg"),),
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
    return Text(widget.choice.getDefaultText());
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