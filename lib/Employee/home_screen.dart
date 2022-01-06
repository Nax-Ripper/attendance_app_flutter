import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:spring1_ui/Employee/profilepage.dart';
import '../main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = FirebaseAuth.instance.currentUser.uid;

   Future<void> _logout(context) async {
      await FirebaseAuth.instance.signOut();
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pop(context);
        FirebaseAuth.instance.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
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
            Text(
              "Employee Profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            // Container(
            //   // height: 300,
            //   // child: Image(image: AssetImage("images/profile.jpg")),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [

            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(50,8,8,8),
            //         child: ClipOval(
            //           child: SizedBox(
            //             width:180,height: 180,
            //             child:  (Image.network(document.data()["profile pic"]))
            //         ),
            //         ),
            //       ),

            //     Padding(
            //       padding: const EdgeInsets.only(top: 80),
            //       child: IconButton(
            //           icon: Icon(Icons.camera_alt_outlined),
            //           onPressed: () async {
            //             //pick image
            //             var image = await ImagePicker.pickImage(
            //                 source: ImageSource.gallery);
            //             // to get path
            //             String filename = basename(image.path);
            //             //set path
            //             var storage =
            //                 FirebaseStorage.instance.ref().child(filename);
            //             // upload
            //             var upload = storage.putFile(image);
            //             // complete
            //             setState(() {
            //               Scaffold.of(context).showSnackBar(
            //                   SnackBar(content: Text("pic uploaded")));
            //             });
            //           }),
            //     ),
            //     ]
            //   ),
            // ),
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
                                  child: ClipOval(
                                    child: Container(
                                      child: SizedBox(
                                          width: 180,
                                          height: 180,
                                          child:
                                          checkprofile(document.data()["profile pic"])
                                          // Image.asset("images/profile.jpg")
                                          //  Image.network(
                                          //     document.data()["profile pic"],fit: BoxFit.fill,)
                                          ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),
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
                  child: Text(
                    widget.Tdate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                    Text(
                      widget.cInTime,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Check Out"),
                    SizedBox(width: 10),
                    Text(
                      widget.cOutTime,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
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
