import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
String uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Profile"),
        backgroundColor: Colors.purple,
        
      ),
      body:
      Container(
        child: Column(
          children: [
            Container(
              height: 300,
                child: Image(image: AssetImage("images/profile.jpg")),
            ),
            Container(
              child: StreamBuilder(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: Text("Welcome ${ document.data()["Fullname"]}",
                                    style:  TextStyle(color: Colors.green[700],fontWeight: FontWeight.bold,fontSize: 20),
                                  ),
                                ),

                                 SizedBox(
                                  height: 30,
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
            )
          ],
        ),
      ), 
    );
  }
}

