import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Employee/attendance.dart';
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
  DateTime moonlanding = DateTime.parse("1969-07-20");
  late DateTime checkin =
      DateTime.parse(checkDate(widget.selectedUser.data()["check in"]));
  late DateTime checkout =
      DateTime.parse(checkDate(widget.selectedUser.data()["check out"]));
  late num Total = 0;
  int cinCount = 1;
  int coutCount = 1;

  String checkDate(String time) {
    if (time == "today") {
      return DateTime.now().toString();
    } else {
      return time;
    }
  }

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
      var diff = difference.inSeconds
          .toString(); // for now set as seconds(demo purpose)
      print(diff);
      var hours = double.parse(diff);
      Total = hours * 10;
      print(Total);
      return Total;
    }
  }

  @override
  Widget build(BuildContext context) {
    void showError(String errormessage) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ERROR'),
              content: Text(errormessage),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          });
    }

    String uid = widget.selectedUser.data()["uid"];

    checkinButton() {
      try {
        if (cinCount > 0) {
          checkin = _getChckin();
          updateCheckin(checkin, uid);
          cinCount--;
        } else {
          throw Exception("Cannot Checkin more then once!");
        }
      } catch (e) {
        showError(e.toString());
      }
    }

    checkoutButton() {
      try {
        if ((checkin.difference(DateTime.now()).inSeconds) <= 0) {
          if (coutCount > 0) {
            checkout = _getCheckout();
            updateCheckout(checkout, uid);
            var money = _differenceInHours(checkin, checkout);
            updateEmployeeAmount(money, uid);
            setAttendeceHistory(checkout, checkin, money, uid);
            coutCount--;
          } else {
            throw Exception("Cannot Checkout more then once!");
          }
        } else {
          throw Exception("Please Checkin First!");
        }
      } catch (e) {
        showError(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Record of ${widget.selectedUser.data()["Fullname"].toString().toUpperCase()}"),
      ),
      body: Container(
        child: Center(
          //
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Employee")
                .where("uid", isEqualTo: uid)
                .snapshots(),
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
                                height: 105,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Full Name : ${document.data()["Fullname"].toString().toUpperCase()}",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Checkin : ",
                                      style: TextStyle(fontSize: 20)),
                                  formaDtate2(
                                      document.data()["check in"].toString()),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Checkout : ",
                                      style: TextStyle(fontSize: 20)),
                                  formaDtate2(
                                      document.data()["check out"].toString()),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                  "Total Amount : RM ${document.data()["Total Amount"]}",
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    child: Text("Checkin",
                                        style: TextStyle(fontSize: 20)),
                                    onPressed: () {
                                      checkinButton();
                                    },
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                10),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green)),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  ElevatedButton(
                                    child: Text("Checkout",
                                        style: TextStyle(fontSize: 20)),
                                    onPressed: () {
                                      checkoutButton();
                                    },
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                10),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red)),
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

Widget formaDtate2(String time) {
  String hours;
  if (time != "today") {
    var date = time.substring(0, 10);
    hours = time.substring(11, 16);
    var today = DateTime.now().toString();
    if (date == today.substring(0, 10)) {
      return Text(
        date + " At " + hours,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 32, 224, 38),
            fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        date + " At " + hours,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      );
    }
  } else {
    return Text(
      "No record",
      textAlign: TextAlign.center,
    );
  }
}
