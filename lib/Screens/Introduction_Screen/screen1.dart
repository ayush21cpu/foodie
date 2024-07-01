import 'package:flutter/material.dart';
import 'package:food_delivery/Common/Style/text.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 10,top: 50),
          child: Column(
            children: [
              Image.asset("images/screen1.png",fit:BoxFit.fitWidth,),
              const SizedBox(height:30,),
              Text("Select from Our \n Best Menu",style: TitleText.titleTextFieldStyle(),textAlign: TextAlign.center,),
              const SizedBox(height: 17,),
              Text("Pick your food from our menu \n More than 35 times",style: ItalicText.italicTextFieldStyle(),textAlign: TextAlign.center,)
            ],
          ),
      ),
    );
  }
}
