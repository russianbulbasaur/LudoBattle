import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ludo_macha/Models/Game.dart';
import 'package:ludo_macha/Models/LiveGame.dart';
import 'package:ludo_macha/Screens/ViewGame.dart';
import 'package:ludo_macha/blocs/play/OpenChallengesBloc.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
import 'package:ludo_macha/common/IconAndText.dart';

import '../blocs/play/LiveGamesBloc.dart';
import '../common/ErrorDialog.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  List<String> dummy = ["","",""];
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(floatingActionButton:
      rankFab(),appBar: CustomAppBar(title: "Play Game",onBackArrowTap: (){
      Navigator.pop(context);
    },),body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => OpenChallengesBloc()),
          BlocProvider(create: (context) => LiveGamesBloc())
        ],
          child: Column(children: [
            ludoLottie(),
            SizedBox(height: 10.h,),
            host(),
            SizedBox(height: 10.h,),
            openChallenges(),
            SizedBox(height: 10.h,),
            liveGames()
          ],),
        ),
      ),
    ),));
  }

  Widget ludoLottie(){
    return SizedBox(height: 80.h,
      child: StreamBuilder(stream: Future.delayed(Duration(seconds: 1),() {
        return 0;
      },).asStream(),
        builder: (context,snap){
           return (snap.hasData && snap.data==0)?LottieBuilder.asset("images/ludo.json",
             repeat: false,
           ):
           Container();
        },
      ),
    );
  }

  Widget openChallenges(){
    return BlocBuilder<OpenChallengesBloc,List<Game>>(
      builder: (context,state){
        return Column(mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 46.h,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white10
            ),padding: EdgeInsets.all(10.w),
              child: Row(children: [
                SizedBox(width: 10.w,),
                const Icon(Icons.arrow_forward_rounded,color: Colors.green,),
                SizedBox(width: 3.w,),
                Text("Open challenges",style: GoogleFonts.rubik(
                    color: Colors.green
                ),),
                const Spacer(),
                TextButton(onPressed: (){},style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white10),shape:
                WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),),
                  child: IconText(icon:  Icon(Icons.refresh,size: 15.w,color: Colors.white,),
                      text: "Reload",style: GoogleFonts.rubik(color: Colors.white)),),
                SizedBox(width: 10.w,)
              ],),),
            SizedBox(height: 10.h,),
            Column(mainAxisSize: MainAxisSize.min,
              children: state.map((e){
                return Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: openChallengeTile(e),
                );
              }).toList(),)
          ],);
      },
    );
  }
  
  Widget openChallengeTile(Game game){
    return Container(height: 60.h,decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.black45
    ),padding: EdgeInsets.all(10.w),
      child: Row(children: [
        SizedBox(width: 10.w,),
        IconText(icon: Icon(Icons.currency_rupee,color:Color(0xff2AE716)),
          text: game.winning.toString(),
          style:
          GoogleFonts.rubik(color: Color(0xff2AE716)),),
        SizedBox(width: 10.w,),
        Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            CircleAvatar(backgroundColor: Colors.blue,child:
            Center(child: Icon(Icons.person,size:15.sp,),),
            radius: 10.sp,),
            SizedBox(width: 3.w,),
            Text(game.hostName,style: GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),)
          ],),
          SizedBox(height: 4.h,),
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            Text("Winning : ",style: GoogleFonts.rubik(color: Colors.white30,),),
            IconText(icon: Icon(Icons.currency_rupee,color: Colors.orange,size: 9.sp,),
              text: game.winning.toString(),
              style: GoogleFonts.rubik(fontSize: 10.sp,color: Colors.orange),)
          ],)
        ],),
        Spacer(),
      TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ViewGame(game: game);
        }));
      },style: ButtonStyle(backgroundColor:
      WidgetStateProperty.all((game.type==GameType.host)?Colors.red:Colors.lightBlue),shape:
      WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),),
          child: Text((game.type==GameType.host)?"\t\t\tCancel\t\t\t":"\t\t\tAccept\t\t\t",style: GoogleFonts.rubik(color: Colors.white)))
      ],),);
  }

  Widget liveGames(){
    return BlocBuilder<LiveGamesBloc,List<LiveGame>>(
      builder: (context,state){
        return Column(mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 46.h,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white10
            ),padding: EdgeInsets.all(10.w),
              child: Row(children: [
                SizedBox(width: 10.w,),
                const Icon(Icons.arrow_forward_rounded,color: Colors.blue,),
                SizedBox(width: 3.w,),
                Text("Live challenges",style: GoogleFonts.rubik(
                    color: Colors.blue
                ),),
              ],),),
            SizedBox(height: 10.h,),
            Column(mainAxisSize: MainAxisSize.min,
              children: state.map((e){
                return Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: liveChallengeTile(e),
                );
              }).toList(),)
          ],);
      }
    );
  }

  Widget liveChallengeTile(LiveGame game){
    return Container(height: 30.h,decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.black45
    ),padding: EdgeInsets.all(10.w),
      child: Row(children: [
        SizedBox(width: 10.w,),
        IconText(icon: Icon(Icons.currency_rupee,color:Colors.blue), text: game.amount.toString(),
          style:
        GoogleFonts.rubik(color: Colors.blue),),
        SizedBox(width: 10.w,),
        Text("${game.player1} VS ${game.player2}",style: GoogleFonts.rubik(
          fontWeight: FontWeight.bold,
          color: Colors.white70
        ),)
      ],),);
  }

  Widget host(){
    return SizedBox(height: 40.h,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Expanded(flex: 1,
          child: SizedBox(height: 32.h,
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: amountController,
              maxLength: 10,
              decoration: InputDecoration(
                  isDense: true,
                  counterText: "",border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.black12,width: 1.w)
              ),hintText: "Amount",focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.blue,width: 1.w)
              )),),
          ),
        ),
        SizedBox(width: 10.w,),
        Expanded(flex: 1,
          child: TextButton(style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(10.r)))
          ),onPressed: (){
            dummy.add("");
            setState(() {

            });
            if(amountController.text.trim().isEmpty){
              //errorDialog("Invalid amount",context);
              return;
            }
          }, child:
            IconText(icon: const Icon(Icons.gamepad,color: Colors.white,),text: "Host Game",style:
            GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,)),)),
        )
      ],),
    );
  }

  Widget rankFab(){
    return FloatingActionButton(onPressed: (){
      Navigator.pushNamed(context, "/leaderboard");
    },shape: const CircleBorder(),
      child:
      Container(decoration: BoxDecoration(shape: BoxShape.circle,
      border: Border.all(width: 1.h,color: Colors.yellowAccent),color: Colors.green),
      child: const Center(child: Text("No\nRank",textAlign: TextAlign.center,),),),);
  }
}
