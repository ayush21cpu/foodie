import 'package:flutter/material.dart';

import '../../Common/Style/text.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin: const EdgeInsets.only(left: 10,right: 10,top: 50),
        child: Column(
          children: [
            Image.asset("images/screen2.png",fit:BoxFit.fitWidth,),
            const SizedBox(height:30,),
            Text("Easy and Online Payment",style: TitleText.titleTextFieldStyle(),textAlign: TextAlign.center,),
            const SizedBox(height: 17,),
            Text("You can pay cash on delivery and \n Card payment is available",style: ItalicText.italicTextFieldStyle(),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
