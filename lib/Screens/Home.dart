import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Screens/bottomnav.dart';
import 'package:food_delivery/Screens/details.dart';
import 'package:food_delivery/models/ListProducts.dart';
import 'package:food_delivery/models/topProducts.dart';
import 'package:food_delivery/service/database.dart';
import 'package:food_delivery/service/sharedPrefe.dart';

import '../models/categoryProducts.dart';

class Home_Screen extends StatefulWidget {
  static const String id = "Home_Screen";
  Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}
class _Home_ScreenState extends State<Home_Screen> {
  var UserName;
  int? selectedIndex;
  getSharedPrefe()async{
    UserName=await SharedPreferenceHelper().getUserName();
    setState(() {
    });
  }

  Stream?foodItemStream;
  Stream?IteamsStream;
  onload()async{
    foodItemStream=await DatabaseMethods().getFoodItem("Ice-Cream");
    IteamsStream=await DatabaseMethods().getFoodItem("Ice-Cream");
  }
  String price=25.toString();




  @override
  void initState() {
    getSharedPrefe();
    onload();
    BottomNav();
    super.initState();
  }



  StreamBuilder allItem(){
    return StreamBuilder(stream:foodItemStream,builder: (context,AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context,index){
            DocumentSnapshot ds=snapshot.data.docs[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Details_Screen(image: ds["Image"], name: ds['Name'], detail:ds['Detail'] , price: ds['Price'])));
              },
              child: Card(
                elevation: 5 ,
                margin: const EdgeInsets.only(right: 10,left: 10,bottom: 10,),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(ds['Image'],width: 100,height: 100,),
                      Text(ds['Name'],style:TitleText.titleTextFieldStyle(),),
                      Text(ds['Detail'],style:SubTitleText.subTitleTextFieldStyle(),),
                      Text("\$"+ds['Price'],style: TitleText.titleTextFieldStyle(),),
                      //Text(topProdus[index].prize),
                    ],
                  ),
                ),

              ),
            );
          }):CircularProgressIndicator();
    },);
  }

  StreamBuilder allItemVertical(){
    print("h");
    return StreamBuilder(stream:IteamsStream,builder: (context,AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context,index){
            DocumentSnapshot ds=snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Details_Screen(image: ds["Image"], name: ds['Name'], detail:ds['Detail'] , price: ds['Price'])));
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 30),
                elevation: 3,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.network(ds["Image"],width: 99,height: 99,),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ds["Name"],style: TitleText.titleTextFieldStyle().copyWith(fontSize: 15), maxLines: 3,
                                overflow: TextOverflow.ellipsis,), // Handle text overflow
                              Text(ds["Detail"],style: SubTitleText.subTitleTextFieldStyle(),),

                              Text(ds['Price'],textAlign: TextAlign.right,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }):CircularProgressIndicator();
    },);}
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
                    "Hello $UserName,",
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
              child: allItem(),
            ),
            // const SizedBox(height: 5,),
            //ListProducts ListView
            Expanded(
              child: Container(
                height: 299,

                margin: const EdgeInsets.only(left: 10,right: 10,),
                child: allItemVertical(),
              ),
            )

          ],
        ),
      ),
    );
  }
}
