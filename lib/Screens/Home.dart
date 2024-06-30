import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Screens/details.dart';
import 'package:food_delivery/models/ListProducts.dart';
import 'package:food_delivery/models/topProducts.dart';

import '../models/categoryProducts.dart';

class Home_Screen extends StatefulWidget {
  static const String id = "Home_Screen";
  Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  var UserName = "Ayush";
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Hello ${UserName},",
                    style: BoldNameText.boldNameTextFieldStyle(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Delicious Food",
                  style: BoldText.boldTextFieldStyle().copyWith(fontSize: 23,)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Discover and Get Great Food",
                style: ItalicText.italicTextFieldStyle(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),

        //category ListView
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: 95,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: produs.length,
                itemExtent:105,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                          child: Card(
                            elevation: 5,
                            color: produs[index].state
                                ? Colors.black
                                : Colors.white,
                            child: Image.asset(
                              produs[index].imagePath,
                              height: 55,
                              width: 55,
                              color: produs[index].state
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (selectedIndex != null &&
                                  selectedIndex != index) // mtlb jo selected item hai vo khali bhi na ho and jis idx pr present me hai vo idx na ho to use false kr de ge
                                 {
                                // Set previously selected item to false
                                produs[selectedIndex!].state = false;
                              }
                              // Toggle the state of the tapped item
                              produs[index].state = !produs[index].state;
                              selectedIndex =produs[index].state ? index : null;
                            });
                          }),
                      Text(
                        produs[index].name,
                        style: const TextStyle(fontSize: 8),
                      ),
                    ],
                  );
                },
              ),
            ),
        //topProduct ListView
             Container(
               margin: const EdgeInsets.only(left: 10),
               height: 220,
               child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topProdus.length,
                itemBuilder: (context, index){
                 return GestureDetector(
                   onTap: (){
                     Navigator.pushNamed(context, Details_Screen.id);
                   },
                   child: Card(
                                   elevation: 5 ,
                                   margin: const EdgeInsets.only(right: 10,left: 10,bottom: 10,),
                                   child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(topProdus[index].imagePath,width: 100,height: 100,),
                        Text(topProdus[index].title,style:TitleText.titleTextFieldStyle(),),
                        Text(topProdus[index].subTitle,style: SubTitleText.subTitleTextFieldStyle(),),
                        Text(topProdus[index].prize),
                      ],
                    ),
                                   ),

                                 ),
                 );
                              },
                              ),
             ),
          // const SizedBox(height: 5,),
        //ListProducts ListView
          Expanded(
            child: Container(
              height: 299,
              margin: const EdgeInsets.only(left: 10,right: 10,),
              child: ListView.builder(
                  itemCount: ListProdus.length,
                  itemBuilder: (context,index){
                 return GestureDetector(
                 onTap: () {
                   Navigator.pushNamed(context, Details_Screen.id);
                 },
                   child: Card(
                     margin: EdgeInsets.only(bottom: 30),
                     elevation: 3,
                     color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                         children: [
                           Image.asset(ListProdus[index].imagePath,width: 99,height: 99,),
                           const SizedBox(width: 18),
                           Expanded(
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(ListProdus[index].title,style: TitleText.titleTextFieldStyle().copyWith(fontSize: 15), maxLines: 3,
                                 overflow: TextOverflow.ellipsis,), // Handle text overflow
                                   Text(ListProdus[index].subTitle,style: SubTitleText.subTitleTextFieldStyle(),),

                                   Text(ListProdus[index].prize,textAlign: TextAlign.right,),
                                 ],
                               ),
                             ),
                           )
                         ],
                       ),
                    ),

                                 ),
                 );
              }),
            ),
          )

          ],
        ),
      ),
    );
  }
}
