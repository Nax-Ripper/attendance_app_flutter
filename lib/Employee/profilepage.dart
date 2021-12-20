import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spring1_ui/Employee/updateUserProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    void _showUpdatePannel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: UpdateUserProfle());
          });
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Personal Information"),
      //   backgroundColor: Colors.purple,
      // ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Employee").where("uid",isEqualTo: uid).snapshots(),
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
                                  height: 50,
                                ),
                                Container(
                                  child: Text(
                                    "${document.data()["Fullname"].toString().toUpperCase()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Card(
                                  shadowColor: Colors.amber[600],
                                  elevation: 8.5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Icon(Icons.email_outlined),
                                        SizedBox(
                                          width: 45,
                                        ),
                                        Text(
                                          document.data()["email"],
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                    shadowColor: Colors.amber[600],
                                    elevation: 8.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          SizedBox(
                                            width: 45,
                                          ),
                                          Text(
                                            document.data()["address"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )),
                                Card(
                                    shadowColor: Colors.amber[600],
                                    elevation: 8.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone),
                                          SizedBox(
                                            width: 45,
                                          ),
                                          Text(
                                            document.data()["phone"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )),
                                Card(
                                    shadowColor: Colors.amber[600],
                                    elevation: 8.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person_outline_outlined),
                                          SizedBox(
                                            width: 45,
                                          ),
                                          Text(
                                            document.data()["role"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: ElevatedButton( 
                child: Text("Update"),
                onPressed: ()=> _showUpdatePannel()),
                ),
            
          ],
        ),
      ),
    );
  }
}
