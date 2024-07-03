import 'package:flutter/material.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Screens/wallet.dart';

class WalletBtn extends StatelessWidget {   
  
  String text;
  final VoidCallback? voidCallBack;

  
   WalletBtn({super.key,required this.text,required this.voidCallBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      voidCallBack!();
    },style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),backgroundColor: Colors.white,foregroundColor: Colors.black,padding: EdgeInsets.zero,elevation: 0.8), child: Text(text,style:  TitleText.titleTextFieldStyle(),),);
    
  }
}
