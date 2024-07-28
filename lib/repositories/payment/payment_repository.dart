import 'dart:convert';

import 'package:ludo_macha/Models/User.dart';
import 'package:ludo_macha/blocs/payment/payment_bloc.dart';
import 'package:ludo_macha/blocs/payment/payment_events.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
class PaymentRepository{
  User? user;
  String? url;
  BigInt? txnId;
  final PaymentBloc _paymentBloc;
  final int amount;
  PaymentRepository(this._paymentBloc,this.amount);
  void initiatePayment() async{
    try{
      Razorpay razorPay = Razorpay();
      String? orderId = await generateOrderId();
      if(orderId==null) throw "error generating order";
      txnId = await createDepositOrder(orderId);
      if(txnId==null) throw "error creating deposit order";
      razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentErrorHandler);
      razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS,paymentSuccessHandler);
      print("ankit ${user!.phone}");
      var options = {
        'key': 'rzp_test_9eIbrzGEQtX9lI',
        'amount': (amount*100),
        'currency':'INR',
        'name': 'Ludo Macha',
        'description': 'Deposit',
        'order_id': orderId,
        'prefill': {
          'contact': user!.phone,
          'email':"test@test.com"
        }
      };
      razorPay.open(options);
    }catch(e){
      print("Payment Repo (init) : $e");
    }
  }

  void paymentErrorHandler(PaymentFailureResponse response){

  }

  void paymentSuccessHandler(PaymentSuccessResponse response) async{
    String paymentId = response.paymentId!;
    String signature = response.signature!;
    String orderId = response.orderId!;
    try{
      if(user==null) throw "user not set";
      if(url==null) throw "url not set";
      if(txnId==null) throw "txn not set";
      Response response = await patch(Uri.parse("$url/payments/confirm-order"),
      headers: {"authorization":user!.token},
      body: {"signature":signature,"payment_id":paymentId,
      "order_id":orderId,"txn_id":txnId.toString()});
      if(response.statusCode!=200) throw response.body;
      _paymentBloc.add(EndPayment(true,amount));
    }catch(e){
      print("Payment success handler : $e");
    }
  }

  Future<BigInt?> createDepositOrder(String orderId) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userString = prefs.getString("user");
      url = prefs.getString("url");
      if(url==null) throw "url not set";
      if(userString==null) throw "user not in prefs";
      user = User.fromJson(userString);
      Response response = await post(Uri.parse("$url/payments/create-order"),
      body: {"order_id":orderId,"amount":amount.toString()},
      headers: {"authorization":user!.token});
      if(response.statusCode!=200) throw response.body;
      return BigInt.parse(jsonDecode(response.body)["txn_id"].toString());
    }catch(e){
      print("Create Deposit Order : $e");
      return null;
    }
  }


  Future<String?> generateOrderId() async{
    String key = "rzp_test_9eIbrzGEQtX9lI";
    String secret = "RO9rK832rqWNL7h1bJVwACV2";
    try{
      Response response = await post(Uri.parse("https://$key:$secret@api.razorpay.com/v1/orders"),
      headers: {"content-type":"application/json"},
      body: jsonEncode({"amount":(amount*100).toString(),"currency":"INR"}));
      if(response.statusCode!=200) throw response.body;
      return jsonDecode(response.body)["id"];
    }catch(e){
      print("Generate Order ID : $e");
      return null;
    }
  }


  Future<bool> createWithdrawalRequest(String? upiId) async{
    try{
      if(upiId==null) throw "upi is null";
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? url = prefs.getString("url");
      String? userString = prefs.getString("user");
      if(url==null) throw "url not in prefs";
      if(userString==null) throw "user not in prefs";
      User user = User.fromJson(userString);
      Response response = await post(Uri.parse("$url/payments/create-withdraw-request"),
          headers: {"authorization":user.token},
          body: {"amount":amount.toString(),
          "upi_id":upiId});
      if(response.statusCode!=200) throw response.body;
      return true;
    }catch(e){
      print("Withdrawal request Blocc : $e");
      return false;
    }
  }
}