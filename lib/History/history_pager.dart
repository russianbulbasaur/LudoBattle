
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ludo_macha/blocs/history/history_bloc.dart';
import 'package:ludo_macha/common/CustomTable.dart';

import '../common/CustomAppBar.dart';
import 'history_enum.dart';
class HistoryPager extends StatefulWidget {
  final HistoryEnum choice;
  const HistoryPager({super.key,required this.choice});

  @override
  State<HistoryPager> createState() => _HistoryPagerState();
}

class _HistoryPagerState extends State<HistoryPager> {
  final HistoryBloc _historyBloc = HistoryBloc();
  @override
  void initState() {
    _historyBloc.getHistory(widget.choice);
    super.initState();
  }
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
          child: BlocProvider(
            create: (context) => _historyBloc,
            child: BlocBuilder<HistoryBloc,List>(
              builder: (context,state){
                return Column(children: [
                  logo(),
                  SizedBox(height: 10.h,),
                  dataList(state)
                ],);
              }
            ),
          ),
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

  Widget dataList(List data){
    double height = MediaQuery.of(context).size.height/1.8;
    switch(widget.choice){
      case HistoryEnum.games:
        return Expanded(
          child: CustomTable(height: height,
              columnHeaders: const ["ID","Winner","","Amount"],
              dataKeywords: const []
              ,data: data),
        );
      case HistoryEnum.referrals:
        return Expanded(
          child: CustomTable(height: height,
              columnHeaders: const ["User ID","Name","","Date"],dataKeywords: const [],
              data: data),
        );
      case HistoryEnum.transactions:
        return Expanded(
          child: CustomTable(height: height,
              columnHeaders: const ["ID","Date","","Amount"],
              dataKeywords: const ["id","date","","amount"],
              data: data),
        );
    }
  }
}