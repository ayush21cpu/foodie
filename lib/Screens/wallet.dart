import 'package:flutter/material.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Common/widget/walletBtn.dart';

class Wallet_Screen extends StatefulWidget {
  const Wallet_Screen({super.key});

  @override
  State<Wallet_Screen> createState() => _Wallet_ScreenState();
}

class _Wallet_ScreenState extends State<Wallet_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       // margin: EdgeInsets.only(top:50),
        child:Column(
          children: [
            Material(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.only(top: 50,bottom: 10),
                    alignment: Alignment.center,
                    child: Text("Wallet",style: BoldText.boldTextFieldStyle(),),
                ),
            ),
            const SizedBox(height: 20,),
            ListTile(tileColor:
            const Color(0x0f008080),
              leading: Image.asset("images/wallet.png", ),
              title: Text("Your Wallet",style:ItalicText.italicTextFieldStyle(),),
             visualDensity: VisualDensity(vertical: 4),
              subtitle: Text("\$100",style: TitleText.titleTextFieldStyle().copyWith(fontWeight: FontWeight.w600),),
              contentPadding: EdgeInsets.all(10),
            ),
            const SizedBox(height: 20,),

            Container(
              margin: const EdgeInsets.only(left: 10,top:10,bottom: 10),
                alignment:Alignment.topLeft,child: Text("Add money",style: TitleText.titleTextFieldStyle().copyWith(fontSize: 21),)),
           Container(
             margin: EdgeInsets.only(left: 10,right: 10),
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
            const SizedBox(height: 40,),

            ElevatedButton(onPressed: (){}, child:Text("Add Money",style: TitleText.titleTextFieldStyle().copyWith(color: Colors.white,),),style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFF008080),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),), fixedSize: Size(350, 50),),)

          ],
        )
      ),
    );
  }
}
