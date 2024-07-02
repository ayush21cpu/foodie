import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http; // Use 'as http' to avoid conflict with 'post' method
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future createPaymentIntent({required String amount, required String currency}) async {

  final url = Uri.parse("https://api.stripe.com/v1/payment_intents");
  final secretKey = dotenv.env["Secret_Key"];
      final body = {
      'amount': amount,
      'currency': currency.toLowerCase(),
        'payment_method_types[]':'card',
      'description': "Test Donation",
    };

  try{
      final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $secretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      }, body: body
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
      return json;
    } else {
      print("error in payment: ${response.statusCode}");
    }
  }catch(e) {
    throw(HttpException(e.toString()));
  }
}