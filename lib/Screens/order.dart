import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Common/Style/text.dart';

class Order_Screen extends StatefulWidget {
  const Order_Screen({super.key});

  @override
  State<Order_Screen> createState() => _Order_ScreenState();
}

class _Order_ScreenState extends State<Order_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.only(top: 50, bottom: 10),
            alignment: Alignment.center,
            child: Text("Food Cart", style: BoldText.boldTextFieldStyle()),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildCard(),
                _buildCard(),
          
              ],
            ),
          ),
        ),
        const Divider(color: Colors.black54),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Text("Total Price", style: TitleText.titleTextFieldStyle()),
              Spacer(),
              Text("\$15", style: TitleText.titleTextFieldStyle()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
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
        )
      ],
    );
  }

  Widget _buildCard() {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text(
                  "2",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/salad2.png",
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            children: [
              Text(
                "Burger",
                style: TitleText.titleTextFieldStyle(),
              ),
              Text(
                "\$120",
                style: TitleText.titleTextFieldStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
