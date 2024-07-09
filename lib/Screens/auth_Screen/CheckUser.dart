import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Screens/Introduction_Screen/onBoarding_Screen.dart';
import '../bottomnav.dart';


class CheckUser extends StatelessWidget {
  static const String id="CheckUser";
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return  checkUser();
  }
  checkUser(){
      final User= FirebaseAuth.instance.currentUser;

      if(User!=null){
        return const BottomNav();
      }else{
        return const OnBorarding_Screen();
      }
  }
}
