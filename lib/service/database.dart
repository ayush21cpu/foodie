
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  Future addUserDetail(Map<String,dynamic>userInfoMap,String id)async{
    return await FirebaseFirestore.instance.collection('users').doc(id).set(userInfoMap);
  }


  Future<void> UpdateUserwallet(String id, String amount) async {
  try {
  DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(id);

  // Check if the document exists
  DocumentSnapshot doc = await docRef.get();
  if (doc.exists) {
  // Update the document if it exists
  await docRef.update({"Wallet": amount});
  print("User wallet updated successfully.");
  } else {
  // Handle the case where the document does not exist
  print("Document with id $id does not exist.");
  // Optionally, create the document if it does not exist
  await docRef.set({"Wallet": amount});
  print("Document created with id $id.");
  }
  } catch (e) {
  // Handle any errors that occur during the update
  print("Error updating user wallet: $e");
  throw Exception("Error updating user wallet: $e");
  }
  }
  }

