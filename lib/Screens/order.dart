import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/service/database.dart';
import 'package:food_delivery/service/sharedPrefe.dart';

class Order_Screen extends StatefulWidget {
  static const String id = "order_Screen";

  Order_Screen({super.key});

  @override
  State<Order_Screen> createState() => _Order_ScreenState();
}

class _Order_ScreenState extends State<Order_Screen> {
  String? id;
  Stream? foodItemStream;
  double totalPrice = 0.0;
  String totalItem = "0";

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  Future<void> getSharedPref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  Future<void> onLoad() async {
    await getSharedPref();
    foodItemStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {});
  }

  StreamBuilder allItem() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          double newTotalPrice = 0.0;
          int itemCount = snapshot.data.docs.length;
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              Map<String, dynamic> data = ds.data() as Map<String, dynamic>;

              double itemTotalPrice = double.tryParse(data['Price'].toString())! * double.tryParse(data['Quantity'].toString())!;
              newTotalPrice += itemTotalPrice;

              if (index == itemCount - 1) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    totalPrice = newTotalPrice;
                  });
                });
              }

              return Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  elevation: 3,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 70,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              data.containsKey('Quantity') ? data['Quantity'].toString() : 'N/A',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            data.containsKey('Image') ? data['Image'] : '',
                            width: 90,
                            height: 100,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.containsKey('Name') ? data['Name'] : 'Unknown',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.containsKey('Price') && data.containsKey('Quantity')
                                  ? '\$${itemTotalPrice.toStringAsFixed(2)}'
                                  : 'N/A',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              alignment: Alignment.center,
              child: Text("Food Cart", style: BoldText.boldTextFieldStyle()),
            ),
          ),
          SingleChildScrollView(
            child: Container(
             height: MediaQuery.of(context).size.height/1.5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    allItem(),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          const Divider(color: Colors.black54),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text("Total Price", style: TitleText.titleTextFieldStyle()),
                Spacer(),
                Text("\$${totalPrice.toStringAsFixed(2)}", style: TitleText.titleTextFieldStyle()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                fixedSize: Size(MediaQuery.of(context).size.width / 1.2, 20),
              ),
              onPressed: () {},
              child: Text(
                "CheckOut",
                style: TitleText.titleTextFieldStyle().copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
