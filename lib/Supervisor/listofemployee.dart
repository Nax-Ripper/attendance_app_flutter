import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spring1_ui/Employee/profilepage.dart';

import '../Employee/attendance.dart';
import '../FirestoreOperstions.dart';
import 'login.dart';
// package:spring1_uSupervisor/login.dart
import 'package:spring1_ui/Supervisor/login.dart';

class Attendance extends StatefulWidget {
  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool _canSee = true;

  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future getDialog(BuildContext context) {
    TextEditingController mycontroller = TextEditingController();
    var cansee = Icon(Icons.remove_red_eye);
    // bool _canSee = false;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Your Password"),
            content: TextField(
              controller: mycontroller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            actions: [
              TextButton(
                child: Text("Submit"),
                onPressed: () {
                  Navigator.of(context).pop(mycontroller.text.toString());
                },
              )
            ],
          );
        });
  }

  checkpassword(real, enterd) {
    if (real != enterd) {
      print("Failed nooooooooooooooooooooooobbbbbbbbbbbbb");
      return false;
    } else {
      print("Passsssss Nooooooooooooooooob");
      return true;
    }
  }

  goToDetailPage(DocumentSnapshot data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(selectedUser: data)));
  }

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

  // Future<bool> getAuthorised() async {
  //   final LocalAuthentication check = LocalAuthentication();
  //   String _isauthoursed = "Not";
  //   bool canCheckBiometrics = await check.canCheckBiometrics;
  //   List<BiometricType> available = await check.getAvailableBiometrics();
  //   print(canCheckBiometrics);
  //   try {
  //     if (Platform.isAndroid) {
  //       if (available.contains(BiometricType.face)) {
  //         await check.authenticateWithBiometrics(
  //           localizedReason: "Confirm your deletion",
  //         );
  //         //call tempass dialog
  //         print("Hello");
  //       } else {
  //         // getDialog(context);
  //         print("hello form other formate");
  //         return false;
  //       }
  //     }

  //     return true;
  //   } on PlatformException catch (e) {
  //     showError(e.toString());
  //     return false;
  //   }
  // }

  String uid = FirebaseAuth.instance.currentUser!.uid;

  String collection = "Employee";

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
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(motion: ScrollMotion(),
                      // dismissible: DismissiblePane(onDismissed: () {
                      //   list[i].get("email");

                      //   setState(() {
                      //     collection = "Employee";
                      //   });
                      // }),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            var snap = FirebaseFirestore.instance
                                .collection("Supervisor")
                                .doc(FirebaseAuth.instance.currentUser.uid);
                            var snap2 = FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(list[i].data()["uid"]);

                            // Future<bool> isApproved = getAuthorised();
                            // if (isApproved == true) {
                            //   print("approved");
                            // } else {
                            //   print("Failed");
                            // }
                            getDialog(context).then((password) {
                              snap.get().then((value) {
                                // print("Hello theis is tempass " +
                                //     tempass.toString());
                                // print("Hello this is entered password " +
                                //     password.toString());
                                var tempass = value.data()["tempass"];

                                if (tempass == null) {
                                  showError("You are not allowed to delete");
                                } else {
                                  bool flag = checkpassword(
                                      tempass.toString(), password.toString());

                                  if (flag) {
                                    try {
                                      snap2.delete();
                                      setState(() {
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                                "User Deleted Successfully")));
                                      });
                                    } catch (e) {}
                                  } else {
                                    showError("Operation Failed");
                                  }
                                }
                              });
                            });

                            setState(() {
                              collection = "Employee";
                            });
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ]),
                  child: Card(
                    elevation: 8,
                    child: ListTile(
                      title: Text(
                        list[i]["Fullname"],
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(list[i]["phone"]),
                      trailing: getTrailing(list[i]["check in"].toString()),
                      leading: SizedBox(
                        height: 110.0,
                        width: 110.0, // fixed width and height
                        child: checkprofile(list[i]["profile pic"]),
                      ),
                      onTap: () => goToDetailPage(list[i]),
                    ),
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
      var diff = difference.inMinutes
          .toString(); // for now set as seconds(demo purpose)
      print(diff);
      var hours = double.parse(diff);
      Total = hours * 0.02;
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
          //--------------------------> //////
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
                              ),
                              
                              // getDataTable(uid),
                              
                            ],
                          ),
                        ),
                      );
                    }
                    ).toList(),
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
    } else if (date != today.substring(0, 10)) {
      return Text(
        "No record",
        textAlign: TextAlign.center,
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

Widget getTrailing(String checkin) {
  var today = DateTime.now().toString();
  if (checkin == "today") {
    return Icon(
      Icons.cancel_rounded,
      color: Colors.red,
      size: 30,
    );
  } else if (checkin.substring(0, 10) == today.substring(0, 10)) {
    return Icon(
      Icons.check_circle,
      color: Colors.greenAccent[700],
      size: 30,
    );
  }
  return Icon(
    Icons.cancel_rounded,
    color: Colors.red,
    size: 30,
  );
}

// Widget getDataTable(uid) {
//   var ref1 = FirebaseFirestore.instance
//       .collection("Employee")
//       .doc(uid)
//       .collection("History");
  

//   if (ref1 != null) {
//     return Container(
//       child: DataTable(
//         columns: [
//           DataColumn(label: Text("Check In")),
//           DataColumn(label: Text("Check Out")),
//           DataColumn(label: Text("Amount"))
//         ],
//          rows: [
//            DataRow(cells: [
//              DataCell(Text("Hello")),
//              DataCell(Text("Hello")),
//              DataCell(Text("Hello")),

//            ])
//          ]),
//     );
//   } else {
//     return Text("No data found");
//   }
// }

