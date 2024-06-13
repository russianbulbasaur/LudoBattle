import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  const TextIcon({super.key,required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min,children: [
      Text(text),
      SizedBox(width: 5.w),
      Icon(icon)
    ],);
  }
}

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  const IconText({super.key,required this.icon,required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min,children: [
      Text(text),
      SizedBox(width: 5.w),
      Icon(icon)
    ],);
  }
}

