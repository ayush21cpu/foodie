import 'package:flutter/material.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Screens/bottomnav.dart';
import 'package:food_delivery/Screens/order.dart';
import 'package:food_delivery/service/database.dart';
import 'package:food_delivery/service/sharedPrefe.dart';

class Details_Screen extends StatefulWidget {
  static const String id = "Details_Screen";

  final String name;
  final String price;
  final String image;
  final String detail;
  Details_Screen({super.key, required this.image, required this.name, required this.detail, required this.price});

  @override
  State<Details_Screen> createState() => _Details_ScreenState();
}

class _Details_ScreenState extends State<Details_Screen> {
  int count = 1;
  var total;
  String name = "Ice-Cream";
  String? id;

  getSharedPref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  onload() async {
    await getSharedPref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    total = int.parse(widget.price);
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, BottomNav.id);
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined)),
            Image.network(
              widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    widget.name,
                    style: TitleText.titleTextFieldStyle(),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (count > 1) {
                      --count;
                      total = total - int.parse(widget.price);
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  count.toString(),
                  style: BoldNameText.boldNameTextFieldStyle()
                      .copyWith(fontSize: 25),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    ++count;
                    total = int.parse(widget.price) + total;
                    setState(() {});
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.detail,
              style: SubTitleText.subTitleTextFieldStyle(),
            ),
            const SizedBox(height: 25),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            const Divider(
              height: 5,
            ),
            //delivery Time
            Row(
              children: [
                Text(
                  "Delivery Time",
                  style: TitleText.titleTextFieldStyle(),
                ),
                const SizedBox(width: 25),
                const Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                const SizedBox(width: 7),
                Text(
                  "30 min",
                  style: TitleText.titleTextFieldStyle(),
                )
              ],
            ),
            const Divider(
              height: 5,
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            const Spacer(),
            //price and add cart
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: TitleText.titleTextFieldStyle(),
                    ),
                    Text(
                      "\$ $total",
                      style:
                      BoldText.boldTextFieldStyle().copyWith(fontSize: 23),
                    ),
                  ],
                ),
                const Spacer(),
                FloatingActionButton.extended(
                  onPressed: () async {
                    Map<String, dynamic> addFoodCart = {
                      "Name": widget.name,
                      "Price": widget.price,
                      "Quantity": count.toString(),
                      "Image": widget.image,
                    };
                    await DatabaseMethods().addFoodDetail(addFoodCart, id!);
                    if (mounted) { // Check if the widget is still mounted
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Food Added to cart"))
                      );
                    }
                  },
                  label: const Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
