import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/service/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
class AddItem_Screen extends StatefulWidget {
  static const String id="aaa";
  const AddItem_Screen({super.key});

  @override
  State<AddItem_Screen> createState() => _AddItem_ScreenState();
}

class _AddItem_ScreenState extends State<AddItem_Screen> {

  var name=TextEditingController();
  var price= TextEditingController();
  var detail=TextEditingController();



  String selectedCategory='';
  final ImagePicker picker=ImagePicker();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
     title:  Text("Add Item",style: BoldText.boldTextFieldStyle(),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload the Item Picture",style: TitleText.titleTextFieldStyle(),),
            const SizedBox(height: 20,),
              selectedImage==null?Center(
              child: GestureDetector(
                onTap: (){
                  selectImageFromGallery();
                },
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(width:2.5,color: Colors.black38)
                  ),
                  child: const Icon(Icons.camera_alt_outlined,color: Colors.black,size: 30,),
                ),
              ),
            ):Center(
                child: GestureDetector(
                  onTap: (){
                    selectImageFromGallery();
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                        color: const Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(width:2.5,color: Colors.black38)
                    ),
                    child:ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.file(selectedImage!,fit: BoxFit.cover,)),
                  ),
                ),
              ),
            const SizedBox(height: 25,),
              Text("Item Name",style: TitleText.titleTextFieldStyle(),),
              const SizedBox(height: 10,),
              TextField(controller: name,decoration: const InputDecoration(hintText:"Enter Item Name",border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(18)))),),
             const SizedBox(height: 25,),
              Text("Item Price",style: TitleText.titleTextFieldStyle(),),
              const SizedBox(height: 10,),
              TextField(controller: price,decoration: const InputDecoration(hintText:"Enter Item Price",border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(18)))),),
              const SizedBox(height: 25,),
              Text("Item Detail",style: TitleText.titleTextFieldStyle(),),
              const SizedBox(height: 10,),
              TextField(maxLines:4,controller: detail,decoration: const InputDecoration(hintText:"Enter Item Detail",border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(18)))),),
              const SizedBox(height: 25,),
              Text("Select Category",style: TitleText.titleTextFieldStyle(),),
            // SizedBox(height: 10,),
             Container(
               padding: const EdgeInsets.all(9),
                       decoration: BoxDecoration(color: const Color(0xFFececf8),
                       borderRadius: BorderRadius.circular(18)) ,
                       child:DropdownButton(
                       hint: Row(children: [const Text('Select Category'),SizedBox(width:MediaQuery.of(context).size.width/2,),], ), // Adjust the width as needed
                       items: const [DropdownMenuItem(value: "Ice-Cream",child: Text("Ice-Cream"),),DropdownMenuItem(value: "Pizza",child: Text("Pizza"),),DropdownMenuItem(value: "Salad",child: Text("Salad"),),DropdownMenuItem(value: "Burger",child: Text("Burger"),),], onChanged: (value){
                       setState(() {
                         selectedCategory=value!;
                       });
                     }),
             ),
              const SizedBox(height: 25,),
              Center(
                child: ElevatedButton(onPressed: (){UploadItem();},
                    style: ElevatedButton.styleFrom(backgroundColor:Colors.black,foregroundColor:Colors.white,fixedSize: const Size(150, 70),shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                    child:  const Text("Add",style: TextStyle(fontSize: 25),)),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectImageFromGallery() async {
    var returnedImage =await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage=File(returnedImage!.path);
    });
  }

  UploadItem() async {
    if(selectedImage!=null &&name.text!=null&& price.text!=null&&detail.text!=null&&selectedCategory!=null){
      String addId=randomAlphaNumeric(10);
      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child("blogImages/").child(addId);
      final UploadTask task =firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl=await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem={
        "Image":downloadUrl,
        "Name":name.text,
        "Price":price.text,
        "Detail":detail.text,
        "Category":selectedCategory,
      };
      await DatabaseMethods().addFoodItem(addItem, selectedCategory).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
          "Food item added Successfully"
        )));
      });
    }
  }

}
