import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class Share_Screen extends StatefulWidget {
  const Share_Screen({super.key});

  @override
  State<Share_Screen> createState() => _Share_ScreenState();
}

class _Share_ScreenState extends State<Share_Screen> {
  String msg="Hiiiiii";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        child:Center(
          child: IconButton(
            icon: const Icon(Icons.share_outlined,color: Colors.redAccent,size: 50,), onPressed: () { Share.share(msg); },
          ),
        )
      ),
    );
  }
}
