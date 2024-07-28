import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ludo_macha/blocs/payment/payment_events.dart';
import 'package:ludo_macha/blocs/payment/payment_states.dart';
import 'package:ludo_macha/common/CustomAppBar.dart';
import '../blocs/payment/deposit/deposit_bloc.dart';
import '../common/ErrorDialog.dart';
class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  TextEditingController amountController = TextEditingController();
  List<int> amounts = [100,200,300,500,1000,2000,3000,5000];
  List<String> payments = ["images/icons/razorpay.svg",
    "images/icons/bhim.png","images/icons/phonepe.svg","images/icons/rupay.png"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: CustomAppBar(title: "Deposit",onBackArrowTap: (){
      Navigator.pop(context);
    },),body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: BlocProvider(create: (context) => DepositBloc(InProgress(0)),
          child: Column(children: [
            logo(),
            SizedBox(height: 10.h,),
            amountBox(),
            SizedBox(height: 10.h,),
            options(),
            SizedBox(height: 10.h,),
            depositButton(),
            SizedBox(height: 10.h,),
            gateways(),
            SizedBox(height: 30.h,)
          ],),
        ),
      ),
    ),));
  }

  Widget logo(){
    return Container(width: 150.h,height: 150.h,padding: EdgeInsets.all(20.w),
      child:Image.asset("images/icons/logo.png"),);
  }

  Widget amountBox(){
    return Container(decoration: const BoxDecoration(color: Colors.black26),
      padding: EdgeInsets.all(10.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Text("Enter Amount to Deposit",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,)),textAlign: TextAlign.start,),
        SizedBox(height: 4.h,),
        Text("Minimum Deposit Amount is 50. ",style: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: Colors.white30,
              fontSize: 14.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w200,)),),
        SizedBox(height: 10.h,),
        TextField(keyboardType: TextInputType.phone,
          controller: amountController,
          maxLength: 10,
          decoration: InputDecoration(counterText: "",border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.black12,width: 1.w)
          ),hintText: "Amount",focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.teal,width: 1.w)
          )),),
      ],),
    );
  }

  Widget options(){
    return SizedBox(height: 70.h,child:
      GridView.builder(itemCount: amounts.length,gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2.7,
          crossAxisCount: 4,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h
      ),
          itemBuilder: (context,index){
                 return GestureDetector(onTap: (){
                   amountController.text = amounts[index].toString();
                 },
                   child: Container(width: 60.w,height: 30.h,
                   decoration: BoxDecoration(color: const Color(0xff282B2E),
                   borderRadius: BorderRadius.circular(10.r)),
                     child: Center(child: Text(amounts[index].toString()),),),
                 );
          }),);
  }

  Widget depositButton(){
    return BlocConsumer<DepositBloc,PaymentState>(
      listener: (context,state){
        errorDialog((state as Ended).message, context);
      },
      listenWhen: (prev,curr){
        return curr is Ended;
      },
      builder: (context,state){
        return TextButton(style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width,0),),
          backgroundColor: WidgetStateProperty.all(Colors.teal),
        ),onPressed: (){
          int amount = 0;
          try{
            amount = int.parse(amountController.text.trim());
          } catch(e){
            errorDialog("Invalid amount",context);
            return;
          }
          context.read<DepositBloc>().add(StartPayment(amount));
        }, child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle,color: Colors.white,),
            SizedBox(width: 5.w),
            Text("Deposit",style: GoogleFonts.rubik(
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
      }
    );
  }

  Widget gateways(){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: payments.map((e){
      return CircleAvatar(backgroundColor: Colors.white,
        minRadius: 26.w,child:
      (e.endsWith(".png"))?Image.asset(e,height: 26.w,width: 26.w,fit: BoxFit.contain,):
      SvgPicture.asset(e,width: 26.w,height: 26.w,fit: BoxFit.contain,),);
    }).toList());
  }
}
