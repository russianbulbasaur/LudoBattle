import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/common/IconAndText.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onBackArrowTap;
  const CustomAppBar({super.key, 
    required this.title,
    required this.onBackArrowTap
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(right: 25.w),
      height: preferredSize.height,
      decoration: BoxDecoration(color: Theme.of(context).primaryColorDark,border:
      const Border(bottom: BorderSide(color: Colors.white24,width: 2))),
      child: Center(child: Row(children: [
        GestureDetector(onTap: (){
          onBackArrowTap();
        },child: const Icon(Icons.arrow_back)),
        SizedBox(width: 20.w,),
        Text(title),
        const Spacer(),
        const Icon(Icons.wallet),
        SizedBox(width: 4.w,),
        TextIcon(text: "10.0", icon: const Icon(Icons.currency_rupee),style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,)),),
        SizedBox(width: 3.w,),
        const Icon(Icons.refresh,color: Colors.yellow,)
      ],),),
    );
  }
}

