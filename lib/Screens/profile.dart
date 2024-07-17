import 'package:flutter/material.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children:[ Container(
              height: MediaQuery.of(context).size.height/5,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width/2, 50))),
            ),
              SizedBox(height: 20,),
              Center(child:  CircleAvatar(radius:70,backgroundImage: AssetImage("images/food.png"),))
          ]
          ),
        ],
      ),
    );
  }
}
