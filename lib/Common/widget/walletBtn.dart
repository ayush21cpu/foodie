import 'package:flutter/material.dart';
import 'package:food_delivery/Common/Style/text.dart';

class WalletBtn extends StatelessWidget {   
  
  String text;
  
   WalletBtn({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),backgroundColor: Colors.white,foregroundColor: Colors.black,padding: EdgeInsets.zero,elevation: 0.8), child: Text(text,style:  TitleText.titleTextFieldStyle(),),);
    
  }
}
