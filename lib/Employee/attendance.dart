import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendanceHistory extends StatelessWidget {
  const AttendanceHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Column(
        children: [
          Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Employee")
                  .where("uid",
                      isEqualTo: FirebaseAuth.instance.currentUser.uid)
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
                      return Center(
                        child: Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "My Attendance",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DataTable(columns: [
                            DataColumn(label: Text("Date")),
                            DataColumn(label: Text("Check in")),
                            DataColumn(label: Text("Check out")),
                          ], rows: [
                            DataRow(cells: [
                              DataCell(Text("Today")),
                              DataCell(formaDtate(
                                  document.data()["check in"].toString())),
                              DataCell(formaDtate(
                                  document.data()["check out"].toString())),
                            ])
                          ])
                        ]),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ]));
  }
}

Widget formaDtate(String time) {
  String hours;
  if (time !="today") {
    hours = time.substring(11, 16);
    return Text(hours);
  } else {
    return Text("No record found");
  }
}
