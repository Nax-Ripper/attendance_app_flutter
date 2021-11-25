import 'package:cloud_firestore/cloud_firestore.dart';

void CreateUserInFirestore(String name, String email, String uid,String phone,String address) async {
 
  FirebaseFirestore.instance
      .collection("UserData")
      .doc(uid)
      .collection("Biodata")
      .add({
    "Fullname": name,
    "email": email,
    "uid": uid,
    "phone": phone,
    "address" : address,
    "role" : "Employee"
  });
}



