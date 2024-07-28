
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomTable extends StatefulWidget {
  final double height;
  final List<String> columnHeaders;
  final List data;
  final List<String> dataKeywords;
  const CustomTable({super.key,required this.height,required this.columnHeaders,
    required this.dataKeywords,
    required this.data});

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: widget.height,child:
      ListView.builder(cacheExtent: 20,itemBuilder: (context,index){
        if(index==0) return headers();
        widget.data[index-1][""] = "";
        return dataTile(widget.data[index-1]);
      },itemCount: widget.data.length+1,),);
  }

  Widget headers(){
    return Container(height: 40.h,
        decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5.r)),child:
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.columnHeaders.map((e){
      return Center(
        child: SizedBox(width: 70.w,
          child: Text(textAlign: TextAlign.center,e),
        ),
      );
    }).toList(),),);
  }

  Widget dataTile(Map data){
    return Container(height: 40.h,
      decoration: BoxDecoration(color: Colors.white12,
          border: Border(bottom: BorderSide(width: 1.h,color: Colors.white38))),child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.dataKeywords.map((e){
          return SizedBox(width: 40.w,child: Flex(direction: Axis.horizontal,
              children:
              [Flexible(child: Text(textAlign: TextAlign.center,data[e].toString()))]));
        }).toList(),),);
  }
}
