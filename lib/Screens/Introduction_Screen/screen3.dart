import 'package:flutter/material.dart';

import '../../Common/Style/text.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 10,top: 50),
        child: Column(
          children: [
            Image.asset("images/screen3.png",fit:BoxFit.fitWidth,width:400,height: 450,),
            const SizedBox(height:30,),
            Text("Quick Delivery at \n Your Doorstep",style: TitleText.titleTextFieldStyle(),textAlign: TextAlign.center,),
            const SizedBox(height: 17,),
            Text("Deliver your food at your\n Doorstep",style: ItalicText.italicTextFieldStyle(),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
