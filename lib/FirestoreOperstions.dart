import 'package:cloud_firestore/cloud_firestore.dart';

void CreateEmployeeInFirestore(
    String name, String email, String uid, String phone, String address) async {
  FirebaseFirestore.instance.collection("Employee").doc(uid).set({
    "Fullname": name,
    "email": email,
    "uid": uid,
    "phone": phone,
    "address": address,
    "role": "Employee",
    "check in": "today",
    "check out": "today",
    "Total Amount": 0.0,
  });
}



void CreateSupervisorInFirestore(
    String name, String email, String uid, String phone, String address) async {
  FirebaseFirestore.instance.collection("Supervisor").doc(uid).set({
    "Fullname": name,
    "email": email,
    "uid": uid,
    "phone": phone,
    "address": address,
    "role": "Supervisor",
  });
}

Future<bool> updateEmployeeData(String phone, String uid) async {
  try {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Employee").doc(uid);

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


Future<bool> updateSupervisorData(String phone, String uid) async {
  try {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Supervisor").doc(uid);

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



  Future<bool> updateEmployeeAmount(Amount,String uid) async {
    try {
      // var value = double.parse(Amount);
      DocumentReference documentReference1 = FirebaseFirestore.instance
          .collection("Employee")
          .doc(uid);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot1 = await transaction.get(documentReference1);
      
        if (!snapshot1.exists) {
          documentReference1.set({"Total Amount": Amount});
          return true;
        } else {
          var newAmount = snapshot1.data()["Total Amount"] + Amount;

          transaction.update(documentReference1, {"Total Amount": newAmount});

          return true;
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }



  Future<bool> updateCheckin(DateTime checkin,String uid) async {
    try {
      DocumentReference documentReference1 = FirebaseFirestore.instance
          .collection("Employee")
          .doc(uid);

      FirebaseFirestore.instance.runTransaction((transaction) async {

        transaction.update(documentReference1, {
          "check in": checkin.toString(),
        });

      });
      return true;
    } catch (e) {
      return false;
    }
  }




 Future<bool> updateCheckout(DateTime checkout,String uid) async {
    try {
      DocumentReference documentReference1 = FirebaseFirestore.instance
          .collection("Employee")
          .doc(uid);

      FirebaseFirestore.instance.runTransaction((transaction) async {

        transaction.update(documentReference1, {
          "check out": checkout.toString(),
        });

      });
      return true;
    } catch (e) {
      return false;
    }
  }