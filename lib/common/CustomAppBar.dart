import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ludo_macha/common/IconAndText.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(right: 25.w),
      height: preferredSize.height,
      decoration: BoxDecoration(color: Theme.of(context).primaryColorDark,border:
      Border(bottom: BorderSide(color: Colors.black12,width: 4))),
      child: Center(child: Row(children: [
        Icon(Icons.arrow_back),
        SizedBox(width: 20.w,),
        Text(title),
        Spacer(),
        Icon(Icons.wallet),
        SizedBox(width: 4.w,),
        TextIcon(text: "10.0", icon: Icons.currency_rupee),
        SizedBox(width: 3.w,),
        Icon(Icons.refresh,color: Colors.yellow,)
      ],),),
    );
  }
}

