import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Common/Style/text.dart';

import 'AddItem_Screen.dart';
class AdminHome_Screen extends StatefulWidget {
  static const String id="AdminHome_Screen";
  const AdminHome_Screen({super.key});

  @override
  State<AdminHome_Screen> createState() => _AdminHome_ScreenState();
}

class _AdminHome_ScreenState extends State<AdminHome_Screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 50,left: 8,right: 8),
        child: Column(
          children: [
            Text("Home Admin",style:BoldText.boldTextFieldStyle().copyWith(decoration: TextDecoration.none),),
           const SizedBox(height: 35,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AddItem_Screen.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.black,
                ),
                child:Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Image.asset("images/food.jpg",width: 120,height: 120,fit: BoxFit.fill,),
                      const SizedBox(width: 25,),
                      Flexible(child:  Text("Add Food Items",style: SubTitleText.subTitleTextFieldStyle().copyWith(color: Colors.white,fontSize: 25,decoration: TextDecoration.none,fontWeight: FontWeight.normal),)),
                    ],
                  ),
                )
              ),
            )

          ],
        ),
      ),
    );
  }
}
