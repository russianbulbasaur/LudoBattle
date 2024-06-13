import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextIcon extends StatelessWidget {
  final String text;
  final Widget icon;
  TextStyle? style;
  TextIcon({super.key,required this.text,required this.icon,this.style});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min,children: [
      Text(text,style: style,),
      SizedBox(width: 5.w),
      icon
    ],);
  }
}

class IconText extends StatelessWidget {
  final String text;
  final Widget icon;
  TextStyle? style;
  IconText({super.key,required this.icon,required this.text,this.style});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,children: [
      icon, SizedBox(width: 5.w),
      Text(text,style: style,textAlign: TextAlign.center,),
    ],);
  }
}

