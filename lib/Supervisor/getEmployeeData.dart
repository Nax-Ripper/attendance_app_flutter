import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spring1_ui/Employee/attendance.dart';
import 'package:spring1_ui/Supervisor/listofemployee.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

List COUT = [];
List CIN = [];
List Current_Amount = [];

class GetEmployeeData extends StatefulWidget {
  String uid;
  GetEmployeeData(this.uid);

  @override
  State<GetEmployeeData> createState() => _GetEmployeeDataState();
}

class _GetEmployeeDataState extends State<GetEmployeeData> {
  @override
  void initState() {
    CIN.clear();
    COUT.clear();
    Current_Amount.clear();
    super.initState();
  }

  // List COUT = [];
  // List CIN = [];
  // List Current_Amount = [];

// getinfo(cin, cout, amount) {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Employee")
                  .doc(widget.uid)
                  .collection("History")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.yellow[900],
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        var checkin = document.data()["check in"];
                        var checkout = document.data()["check out"];

                        getinfo(
                            document.get("check in"),
                            document.get("check out"),
                            document.get("current amount").toString());

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                formatDateSupervisor(checkout),
                                formaDtateSupervisor(checkin),
                                formaDtateSupervisor(checkout),
                                Text(document
                                    .data()["current amount"]
                                    .toString()),
                                //           getinfo(
                                // document.get("check in"),
                                // document.get("check out"),
                                // document.get("current amount").toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }

                return Text("No data");
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget formatDateSupervisor(String time) {
  // String today = DateTime.now().toString();
  String day;
  if (time != "today") {
    day = time.substring(2, 10);
    return Text(
      day,
      // style: TextStyle(fontSize: 10),
    );
  } else {
    return Text(
      "No Data",
      style: TextStyle(fontSize: 19),
    );
  }
}

Widget formaDtateSupervisor(String time) {
  String hours;
  if (time != "today") {
    hours = time.substring(11, 16);
    return Text(
      hours,
      // textAlign: TextAlign.center,
      // style: TextStyle(fontSize: 19),
    );
  } else {
    return Text(
      "No record",
      textAlign: TextAlign.center,
    );
  }
}

getinfo(cin, cout, amount) {
  // print(cin.toString());
  if (cin != null) {
    // CIN.clear();
    // COUT.clear();
    // Current_Amount.clear();
    CIN.add(cin);
    COUT.add(cout);
    Current_Amount.add(amount);
  } else {
    print("No data found");
  }
}


