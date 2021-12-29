import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({Key? key}) : super(key: key);

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  bool sort = true;
  String Sort = "Ascending";
  // late IconData icon = Icon(Icons.arrow_circle_up) as IconData;
  Widget icon = Icon(Icons.arrow_circle_up);

  @override
  Widget build(BuildContext context) {
    String date = "today", checkin = "today", checkout = "today";

    return Scaffold(
        body: ListView(children: [
      Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "My Attendance",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 47, 170, 16)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          label: Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          icon: icon,
                          onPressed: () {
                            if (sort == true) {
                              setState(() {
                                sort = false;
                                Sort = "Descending";
                                icon = Icon(Icons.arrow_circle_down);
                              });
                            } else if (sort == false) {
                              setState(() {
                                sort = true;
                                Sort = "Ascending ";
                                icon = Icon(Icons.arrow_circle_up);
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                              primary: Colors.black,
                              splashFactory: NoSplash.splashFactory),
                        ),

                        // Text("Date\n",style: TextStyle(fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Check in",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Check out",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // Container(
                //   child: DataTable(columns: [
                //     DataColumn(
                //         label: Text(
                //       "Date",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontSize: 20),
                //     )),
                //     DataColumn(
                //         label: Text(
                //       "Check in",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontSize: 20),
                //     )),
                //     DataColumn(
                //         label: Text(
                //       "Check out",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontSize: 20),
                //     )),
                //   ], rows: [
                //     DataRow(cells: [
                //       DataCell(Text("")),
                //       DataCell(Text("")),
                //       DataCell(Text(""))
                //     ])
                //   ]),
                // ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Employee")
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection("History")
                      .orderBy("check out", descending: sort)
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
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            checkin = document.data()["check in"];
                            checkout = document.data()["check out"];

                            // return DataTable(columns: [
                            //   DataColumn(
                            //       label: Text(
                            //     "",
                            //   )),
                            //   DataColumn(
                            //       label: Text(
                            //     "",
                            //   )),
                            //   DataColumn(
                            //       label: Text(
                            //     "",
                            //   )),
                            // ], rows: [
                            //   DataRow(cells: [
                            //     DataCell(
                            //       formatDate(checkout),
                            //     ),
                            //     DataCell(formaDtate(checkin)),
                            //     DataCell(formaDtate(checkout))
                            //   ])
                            // ]);


                            return Container(
                              // decoration: BoxDecoration(
                              //   border: Border(bottom: BorderSide(width: 2,color: Colors.yellow))
                              // ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: formatDate(checkout),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: formaDtate(checkin),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 30),
                                        child: formaDtate(checkout),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
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
          // ElevatedButton(
          //     child: Text("Sort Date " + Sort),
          //     onPressed: () {
          //       if (sort == true) {
          //         setState(() {
          //           sort = false;
          //           Sort = "Descending";
          //         });
          //       } else if (sort == false) {
          //         setState(() {
          //           sort = true;
          //           Sort = "Ascending ";
          //         });
          //       }
          //     })
        ],
      ),
    ]));
  }
}

Widget formaDtate(String time) {
  String hours;
  if (time != "today") {
    hours = time.substring(11, 16);
    return Text(
      "   " + hours,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 19),
    );
  } else {
    return Text(
      "No record",
      textAlign: TextAlign.center,
    );
  }
}

Widget formatDate(String time) {
  // String today = DateTime.now().toString();
  String day;
  if (time != "today") {
    day = time.substring(0, 10);
    return Text(
      day,
      style: TextStyle(fontSize: 19),
    );
  } else {
    return Text(
      "No Data",
      style: TextStyle(fontSize: 19),
    );
  }
}
