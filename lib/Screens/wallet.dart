import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Common/widget/walletBtn.dart';
import 'package:food_delivery/Stripe/payment.dart';

class Wallet_Screen extends StatefulWidget {
  const Wallet_Screen({super.key});

  @override
  State<Wallet_Screen> createState() => _Wallet_ScreenState();
}

class _Wallet_ScreenState extends State<Wallet_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              "\$100",
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
                WalletBtn(text: "\$100"),
                WalletBtn(text: "\$500"),
                WalletBtn(text: "\$1000"),
                WalletBtn(text: "\$2000"),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              initPaymentSheet();
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

  Future<void> initPaymentSheet() async {
    try {
      // 1. Create payment intent on the server
      final data = await createPaymentIntent(amount: "1000", currency: "usd");

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

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }
}
