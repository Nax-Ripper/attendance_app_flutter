import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = FirebaseAuth.instance.currentUser.uid;

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pop(context);
      FirebaseAuth.instance.currentUser;
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      AlertDialog(
        title: Text("Logout again"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Employee Profile"),
      //   backgroundColor: Colors.purple,
      // ),
      body: Container(
        child: Column(
          children: [

            SizedBox(
              height: 30,
            ),

            Text("Employee Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

            Container(
              height: 300,
              child: Image(image: AssetImage("images/profile.jpg")),
            ),
             
            Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Employee")
                    .where("uid", isEqualTo: uid)
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: Text(
                                    "Welcome ${document.data()["Fullname"]}",
                                    style: TextStyle(
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                  child: Container(
                                    child: Card(
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TodaysDate(
                                            document.data()["check in"],
                                            document.data()["check out"]),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TodaysDate extends StatefulWidget {
  late String checkin, checkout;
  late String Tdate, cInTime, cOutTime;

  TodaysDate(this.checkin, this.checkout) {
    Tdate = getTdate(checkin, checkout);
  }

  String getTdate(String checkin, String checkout) {
    if (checkin == "today") {
      cInTime = "today";
      cOutTime = "today";
      return "today";
    } else {
      var day = checkin.substring(0, 10);
      var cintime = checkin.substring(11, 16);
      var couttime = checkout.substring(11, 16);
      cInTime = cintime;
      cOutTime = couttime;
      return day;
    }
  }

  @override
  _TodaysDateState createState() => _TodaysDateState();
}

class _TodaysDateState extends State<TodaysDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(widget.Tdate,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Container(
              child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Check In"),
                    SizedBox(width: 10),
                    Text(widget.cInTime,style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Check Out"),
                    SizedBox(width: 10),
                    Text(widget.cOutTime,style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
