import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FirestoreOperstions.dart';

class Attendance extends StatefulWidget {
  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  goToDetailPage(DocumentSnapshot data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(selectedUser: data)));
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Employee").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final list = snapshot.data!.docs;
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 8,
                  child: ListTile(
                    title: Text(list[i]["Fullname"]),
                    subtitle: Text(list[i]["phone"]),
                    onTap: () => goToDetailPage(list[i]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot selectedUser;
  DetailPage({required this.selectedUser});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DateTime checkin, checkout;
  late num Total = 0;


  DateTime _getChckin() {
    DateTime currentCheckIN = new DateTime.now();
    print(currentCheckIN);
    return currentCheckIN;
  }

  DateTime _getCheckout() {
    DateTime currentCheckout = new DateTime.now();
    print(currentCheckout);
    return currentCheckout;
  }

  _differenceInHours(DateTime cin, DateTime cout) {
    Duration difference = checkout.difference(checkin);

    print(difference.inHours);

    if (!difference.isNegative) {
      var diff = difference.inSeconds.toString(); // for now set as seconds(demo purpose)
      print(diff);
      var hours = double.parse(diff);
      Total = hours * 10;
      print(Total);
      return Total;
    }
  }


    bool _validateTime(DateTime s, DateTime e) {
    Duration d = e.difference(s);
    DateTime diff = e.subtract(d);
    print(d);
    print(diff);
    if (d.isNegative) {
      // print(diff);
      return false;
    } else {
      return true;
    }
  }



  @override
  Widget build(BuildContext context) {
       String uid = widget.selectedUser.data()["uid"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Record of ${widget.selectedUser.data()["Fullname"]}"),
      ),
      body: Container(
        child: Center(
          //
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Employee").where("uid",isEqualTo: uid).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                child: Container(
                  child: Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("Fullname : ${document.data()["Fullname"]}"),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Checkin time : ${document.data()["check in"]}"),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Checkout time : ${document.data()["check out"]}"),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Total Amount : RM ${document.data()["Total Amount"]}"),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      child: Text("Checkin"),
                                      onPressed: () {
                                        checkin = _getChckin();
                                        updateCheckin(checkin,uid);
                                      }),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    child: Text("Checkout"),
                                    onPressed: () {
                                      checkout = _getCheckout();
                                      var checkinfromdb = DateTime.parse(
                                          document.data()["check in"]);
                                      var iserror = _validateTime(
                                          checkinfromdb, checkout);
                                      if (iserror == true) {
                                        updateCheckout(checkout,uid);
                                        var money = _differenceInHours(
                                            checkin, checkout);

                                        updateEmployeeAmount(money,uid);
                                      } else {
                                        print("Cant update");
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
