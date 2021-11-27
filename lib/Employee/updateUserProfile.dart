import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FirestoreOperstions.dart';

class UpdateUserProfle extends StatefulWidget {
  const UpdateUserProfle({Key? key}) : super(key: key);

  @override
  _UpdateUserProfleState createState() => _UpdateUserProfleState();
}

class _UpdateUserProfleState extends State<UpdateUserProfle> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  late String _phoneNumber = "";
  var initialvalue = "0123456";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("UserData")
                  .doc(uid)
                  .collection("Biodata")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Container(
                  child: Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return Container(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Update your profile ",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                initialValue: initialvalue =
                                    document.data()["phone"],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter phone Number";
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                    labelText: "Phone number",
                                    prefixIcon: Icon(Icons.phone),
                                    hintText: "01154785422",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                                onChanged: (value) {
                                  setState(() {
                                    _phoneNumber = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      child: Text("Save"),
                                      onPressed: () async {
                                        if (_phoneNumber.isEmpty) {
                                          _phoneNumber =
                                              initialvalue + _phoneNumber;
                                          Navigator.pop(context);
                                        } else {
                                          updateData(_phoneNumber, uid);
                                          Navigator.pop(context);
                                        }
                                      }),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      child: Text("Cancle"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
