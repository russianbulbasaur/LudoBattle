import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomTable extends StatefulWidget {
  final double height;
  final List<String> columnHeaders;
  final List<Map<String,String>> data;
  const CustomTable({super.key,required this.height,required this.columnHeaders,required this.data});

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  @override
  Widget build(BuildContext context) {
    return Container(height: widget.height,child:
      ListView.builder(cacheExtent: 100,itemBuilder: (context,index){
        if(index==0) return headers();
        return dataTile(widget.data[index-1]);
      },itemCount: widget.data.length+1,),);
  }

  Widget headers(){
    return Container(height: 40.h,
        decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5.r)),child:
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.columnHeaders.map((e){
      return SizedBox(width: 40.w,child: Flexible(child: Text(textAlign: TextAlign.center,e)));
    }).toList(),),);
  }

  Widget dataTile(Map<String,String> data){
    return Container(height: 40.h,
      decoration: BoxDecoration(color: Colors.white12,
          border: Border(bottom: BorderSide(width: 1.h,color: Colors.white38))),child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.columnHeaders.map((e){
          return SizedBox(width: 40.w,child: Flexible(child: Text(textAlign: TextAlign.center,data[e].toString())));
        }).toList(),),);
  }
}
