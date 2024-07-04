import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Common/widget/walletBtn.dart';
import 'package:food_delivery/Screens/auth_Screen/singup_Screen.dart';
import 'package:food_delivery/Stripe/payment.dart';
import 'package:food_delivery/service/sharedPrefe.dart';

import '../service/database.dart';

class Wallet_Screen extends StatefulWidget {
  const Wallet_Screen({super.key});
  @override
  State<Wallet_Screen> createState() => _Wallet_ScreenState();
}

class _Wallet_ScreenState extends State<Wallet_Screen> {
  String? wallet, id;
  var amountController = TextEditingController();
  var totalAmount = 0;

  @override
  void initState() {
    super.initState();
    getsharedpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null?CircularProgressIndicator():Column(
        children: [
          Material(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              alignment: Alignment.center,
              child: Text("Wallet", style: BoldText.boldTextFieldStyle()),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            tileColor: const Color(0x0f008080),
            leading: Image.asset("images/wallet.png"),
            title: Text("Your Wallet", style: ItalicText.italicTextFieldStyle()),
            visualDensity: const VisualDensity(vertical: 4),
            subtitle: Text(
              totalAmount.toString().trim(),
              style: TitleText.titleTextFieldStyle().copyWith(fontWeight: FontWeight.w600),
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            alignment: Alignment.topLeft,
            child: Text("Add money", style: TitleText.titleTextFieldStyle().copyWith(fontSize: 21)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WalletBtn(text: "\$100", voidCallBack: () { initPaymentSheet("100"); },),
                WalletBtn(text: "\$500", voidCallBack: () { initPaymentSheet("500"); },),
                WalletBtn(text: "\$1000", voidCallBack: () { initPaymentSheet("1000"); },),
                WalletBtn(text: "\$2000", voidCallBack: () { initPaymentSheet("2000"); },),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Enter the amount"),
                  content: TextField(
                    controller: amountController,
                    decoration: const InputDecoration(hintText: "Amount"),
                    keyboardType: TextInputType.number,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () { Navigator.of(context).pop(); initPaymentSheet(amountController.text.trim()); },
                      child: Text("Add Money"),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF008080),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              fixedSize: const Size(350, 50),
            ),
            child: Text(
              "Add Money",
              style: TitleText.titleTextFieldStyle().copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initPaymentSheet(String amount) async {
    try {
      // 1. Create payment intent on the server
      final data = await createPaymentIntent(amount: calculateAmount(amount), currency: "usd");

      if (data.isEmpty || !data.containsKey('client_secret')) {
        throw Exception("Failed to create payment intent");
      }

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: data['client_secret'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          style: ThemeMode.dark,
        ),
      );

      // 3. Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // Show a dialog or toast on successful payment
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              Text("Payment Successful"),
            ],
          ),
        ),
      );

      // Update total amount
      setState(() {
        totalAmount = (int.parse(wallet ?? '0')) + int.parse(amount); // Ensure the UI updates with the new amount
      });
      await SharedPreferenceHelper().saveUserWallet(totalAmount.toString());
      await getsharedpref();
      print("Updating wallet for id: $id with amount: $totalAmount");
      await DatabaseMethods().UpdateUserwallet(id!, totalAmount.toString().trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  String calculateAmount(String amount) {
    return (int.parse(amount) * 100).toString().trim();
  }

  Future<void> getsharedpref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {
      totalAmount = int.parse(wallet ?? '0'); // Set totalAmount with wallet value
    });
    print("Retrieved wallet: $wallet and id: $id");
  }
}

class DatabaseMethods {
  Future<void> UpdateUserwallet(String id, String amount) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(id);

      // Check if the document exists
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        // Update the document if it exists
        await docRef.update({"Wallet": amount});
        print("User wallet updated successfully.");
      } else {
        // Handle the case where the document does not exist
        print("Document with id $id does not exist.");
        // Optionally, create the document if it does not exist
        await docRef.set({"Wallet": amount});
        print("Document created with id $id.");
      }
    } catch (e) {
      // Handle any errors that occur during the update
      print("Error updating user wallet: $e");
      throw Exception("Error updating user wallet: $e");
    }
  }
}
