import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ludo_macha/Models/Game.dart';
import 'package:ludo_macha/Models/LiveGame.dart';
import 'package:ludo_macha/Screens/ViewGame.dart';
import 'package:ludo_macha/blocs/game/game_bloc.dart';
import 'package:ludo_macha/blocs/game/game_creation_bloc.dart';
import 'package:ludo_macha/blocs/game/game_events.dart';
import 'package:ludo_macha/blocs/game/game_states.dart';
import 'package:ludo_macha/blocs/play/open_challenges_bloc.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
import 'package:ludo_macha/common/ErrorDialog.dart';
import 'package:ludo_macha/common/IconAndText.dart';

import '../blocs/game/game_monitor_bloc.dart';
import '../blocs/play/live_games_bloc.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> with TickerProviderStateMixin{
  List<String> dummy = ["","",""];
  TextEditingController amountController = TextEditingController();
  final GameCreationBloc _gameCreationBloc = GameCreationBloc();
  final OpenChallengesBloc _openChallengesBloc = OpenChallengesBloc();
  final LiveGamesBloc _liveGamesBloc = LiveGamesBloc();
  GameMonitorBloc? _gameMonitorBloc;
  final HashMap<BigInt,List> animationCache = new HashMap();

  @override
  void initState() {
    _openChallengesBloc.challengeScrapper();
    _liveGamesBloc.liveGameScrapper();
    super.initState();
  }

  @override
  void dispose() {
    _openChallengesBloc.openChallengeIsolate.kill();
    _liveGamesBloc.liveGamesIsolate.kill();
    if(GameMonitorBloc.gameMonitor!=null) GameMonitorBloc.gameMonitor!.kill();
    super.dispose();
  }

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
          BlocProvider(create: (context) => _openChallengesBloc),
          BlocProvider(create: (context) => _liveGamesBloc),
          BlocProvider(create: (context) => _gameCreationBloc)
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
      child: StreamBuilder(stream: Future.delayed(const Duration(seconds: 1),() {
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
                TextButton(onPressed: (){
                  openChallengeServiceRestart();
                },style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white10),shape:
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
    if(game.type==GameType.host) return openChallengeTileHost(game);
    return openChallengeTileOther(game);
  }


  Widget openChallengeTileHost(Game game){
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GameBloc(game)),
        BlocProvider(create: (context) => GameMonitorBloc(game,game))
      ],
      child: BlocListener<GameMonitorBloc,Game>(listener: (context,state){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return ViewGame(game: state);
        }));
      },listenWhen: (prev,curr){
        return curr.status==GameStatus.waiting;
      },
      child: BlocConsumer<GameBloc,GameState>(listener: (context,state){
        openChallengeServiceRestart();
      },listenWhen: (prev,curr){
        return (curr is GameDeletedState);
      },
          builder: (context,state){
            return Container(height: 60.h,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.black45
            ),padding: EdgeInsets.all(10.w),
              child: Row(children: [
                SizedBox(width: 10.w,),
                IconText(icon: const Icon(Icons.currency_rupee,color:Color(0xff2AE716)),
                  text: game.winning.toString(),
                  style:
                  GoogleFonts.rubik(color: const Color(0xff2AE716)),),
                SizedBox(width: 10.w,),
                Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                    CircleAvatar(backgroundColor: Colors.blue,
                      radius: 10.sp,child:
                      Center(child: Icon(Icons.person,size:15.sp,),),),
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
                const Spacer(),
                TextButton(onPressed: (){
                  context.read<GameBloc>().add(DeleteGameEvent(game.id));
                },style: ButtonStyle(backgroundColor:
                WidgetStateProperty.all((game.type==GameType.host)?Colors.red:Colors.lightBlue),shape:
                WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),),
                    child: Text("\t\t\tCancel\t\t\t",style: GoogleFonts.rubik(color: Colors.white)))
              ],),);
          }),),
    );
  }

  List heightAnimationFactory(){
    AnimationController heightController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 400));
    Tween<double> heightTween = Tween(begin: 0,end: 40.h);
    Animation<double> heightAnimation = heightTween.animate(heightController);
    return [heightController,heightAnimation];
  }

  Widget openChallengeTileOther(Game game){
    late Animation heightAnimation;
    late AnimationController heightController;
    if(animationCache.containsKey(game.id)) {
      List animations = animationCache[game.id]!;
      heightAnimation = animations[1];
      heightController = animations[0];
    }else{
      List animations = heightAnimationFactory();
      heightAnimation = animations[1];
      heightController = animations[0];
      animationCache[game.id] = animations;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GameBloc(game)),
        BlocProvider(create: (context) => GameMonitorBloc(game,game))
      ],
      child: BlocBuilder<GameBloc,GameState>(
      builder: (context,state){
        return Container(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.black45
        ),padding: EdgeInsets.all(10.w),
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                SizedBox(width: 10.w,),
                IconText(icon: const Icon(Icons.currency_rupee,color:Color(0xff2AE716)),
                  text: game.winning.toString(),
                  style:
                  GoogleFonts.rubik(color: const Color(0xff2AE716)),),
                SizedBox(width: 10.w,),
                Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                    CircleAvatar(backgroundColor: Colors.blue,
                      radius: 10.sp,child:
                      Center(child: Icon(Icons.person,size:15.sp,),),),
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
                const Spacer(),
                TextButton(onPressed: (){
                  context.read<GameBloc>().add(ShowStartPlayingEvent());
                  heightController.reset();
                  heightController.forward();
                },style: ButtonStyle(backgroundColor:
                WidgetStateProperty.all((game.type==GameType.host)?Colors.red:Colors.lightBlue),shape:
                WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),),
                    child: Text("\t\t\tAccept\t\t\t",style: GoogleFonts.rubik(color: Colors.white)))
              ],),
              SizedBox(height:10.h),
              AnimatedBuilder(
                animation: heightAnimation,
                builder: (context,child){
                  return SizedBox(height: heightAnimation.value
                  ,child: playerButtons(state,context.read<GameBloc>()));
                },
              )
            ],
          ),);
      }),
    );
  }

  Widget playerButtons(GameState state,GameBloc gameBloc){
    if(state is ShowStartPlayingState) {
      return TextButton(style: ButtonStyle(minimumSize:
      WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0),),
          backgroundColor: WidgetStateProperty.all(Colors.orange),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius:
          BorderRadius.circular(10.r)))
      ),onPressed: (){
        gameBloc.add(AcceptGameEvent());
      }, child:
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_box,color: Colors.white,),
          SizedBox(width: 5.w),
          Text("Start Playing",style: GoogleFonts.rubik(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,)),),
          SizedBox(width: 10.w,),
          Visibility(visible: false,child: SizedBox(width: 10.w,
              height: 10.h
              ,child: const CircularProgressIndicator(color: Colors.white,)))
        ],));
    }else if(state is GameAcceptedState) {
      return awaitingCancelButton();
    }
    return Container();
  }

  Widget awaitingCancelButton(){
    return SizedBox(height: 40.h,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(flex: 1,
            child: TextButton(style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(10.r)))
            ),onPressed: (){
            }, child:
            IconText(icon: const Icon(Icons.timelapse_outlined,color: Colors.white,),text: "Awaiting",style:
            GoogleFonts.rubik(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,)),)),
          ),
          SizedBox(width: 10.w,),
          Expanded(flex: 1,
            child: TextButton(style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(10.r)))
            ),onPressed: (){
            }, child:
            IconText(icon: const Icon(Icons.cancel,color: Colors.white,),text: "Cancel",style:
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
        IconText(icon: const Icon(Icons.currency_rupee,color:Colors.blue), text: game.amount.toString(),
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
    return BlocConsumer<GameCreationBloc,GameState>(listener: (context,state){
      if(state is GameErrorState){
        errorDialog("Some error occured", context);
        return;
      }
      if(state is GameAcceptedState){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
          return ViewGame(game: (state).game);
        }));
        return;
      }
      openChallengeServiceRestart();
    }, builder: (context,state){
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
                  try{
                    int amount = int.parse(amountController.text.trim());
                    if(amount<50) throw "Amount too less";
                    context.read<GameCreationBloc>().createGame(amount);
                  }catch(e){
                    errorDialog("Invalid amount", context);
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

  void openChallengeServiceRestart(){
    _openChallengesBloc.openChallengeIsolate.kill();
    _openChallengesBloc.challengeScrapper();
  }

  void liveGamesServiceRestart(){
    _liveGamesBloc.liveGamesIsolate.kill();
    _liveGamesBloc.liveGameScrapper();
  }
}
