import 'package:cloud_firestore/cloud_firestore.dart';

void CreateUserInFirestore(
    String name, String email, String uid, String phone, String address) async {
  FirebaseFirestore.instance
      .collection("UserData")
      .doc(uid)
      .collection("Biodata")
      .doc(uid)
      .set({
    "Fullname": name,
    "email": email,
    "uid": uid,
    "phone": phone,
    "address": address,
    "role": "Employee"
  });
}

 Future<bool> updateData(String phone,String uid) async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("UserData")
          .doc(uid)
          .collection("Biodata").doc(uid);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);

        transaction.update(documentReference, {
          "phone": phone,
        });
      });
      return true;
    } catch (e) {
      return false;
    }
  }
