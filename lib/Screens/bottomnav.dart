import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Screens/Home.dart';
import 'package:food_delivery/Screens/order.dart';
import 'package:food_delivery/Screens/profile.dart';
import 'package:food_delivery/Screens/wallet.dart';

import 'Introduction_Screen/Share_Screen.dart';

class BottomNav extends StatefulWidget {
  static const String id="BottomNav";
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex=0;
 late List<Widget> pages;
  late Widget currentPage;
  late Home_Screen homePage;
  late Order_Screen order;
  late Profile_Screen profile;
  late Wallet_Screen wallet;
  late Share_Screen share;
  @override
  void initState() {
     homePage=Home_Screen();
     order= Order_Screen();
     profile=const Profile_Screen();
     wallet=const Wallet_Screen();
     share=const Share_Screen();
     pages=[homePage,order,wallet,profile,share];

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.black,
        backgroundColor: Colors.white,
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
          });
        },
        items:
      const [
        Icon(Icons.home_outlined,color: Colors.white,),
        Icon(Icons.shopping_bag_outlined, color: Colors.white,),
        Icon(Icons.wallet_outlined,color: Colors.white,),
        Icon(Icons.person_outline,color: Colors.white,),
        Icon(Icons.share_outlined,color:Colors.white,),

       ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
