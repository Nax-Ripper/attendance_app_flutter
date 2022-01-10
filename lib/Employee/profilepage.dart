import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spring1_ui/Employee/updateUserProfile.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  late File _image;

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
                                Container(
                                  // height: 300,
                                  // child: Image(image: AssetImage("images/profile.jpg")),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 8, 8, 8),
                                          child: ClipOval(
                                            child: Container(
                                              child: SizedBox(
                                                  width: 180,
                                                  height: 180,
                                                  child: checkprofile(document
                                                      .data()["profile pic"])

                                                  // (Image.network(document.data()["profile pic"])==null)
                                                  // ?  Image.file(
                                                  //         _image,
                                                  //         fit: BoxFit.fill,
                                                  //       )
                                                  //     : Image(
                                                  //         image: AssetImage(
                                                  //             "images/profile.jpg"),
                                                  //       )

                                                  //     Image.network(
                                                  //   document
                                                  //       .data()["profile pic"],
                                                  //   fit: BoxFit.fill,
                                                  // )
                                                  // ((_image) != null)
                                                  //     ? Image.file(
                                                  //         _image,
                                                  //         fit: BoxFit.fill,
                                                  //       )
                                                  //     : Image(
                                                  //         image: AssetImage(
                                                  //             "images/profile.jpg"),
                                                  //       ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 80),
                                          child: IconButton(
                                              icon: Icon(
                                                  Icons.camera_alt_outlined),
                                              onPressed: () async {
                                                //pick image
                                                _image =
                                                    await ImagePicker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {
                                                  _image = _image;
                                                });

                                                String filename =
                                                    basename(_image.path);
                                                //set path
                                                var storage = FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child(filename);
                                                print(storage.toString());

                                                // upload
                                                var upload = await storage
                                                    .putFile(_image);
                                                var url = await storage
                                                    .getDownloadURL();
                                                print(
                                                    "The url is hellooo" + url);
                                                FirebaseFirestore.instance
                                                    .collection("Employee")
                                                    .doc(uid)
                                                    .update({
                                                  "profile pic": url,
                                                });
                                                var photo = FirebaseAuth
                                                    .instance
                                                    .currentUser
                                                    .photoURL;
                                                print(photo);
                                                // complete
                                                setState(() {
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "pic uploaded")));
                                                });

                                                // // to get path
                                                // String filename =
                                                //     basename(_image.path);
                                                // //set path
                                                // var storage = FirebaseStorage
                                                //     .instance
                                                //     .ref()
                                                //     .child(filename);
                                                // // upload
                                                // var upload =
                                                //     storage.putFile(_image);
                                                // // complete
                                                // setState(() {
                                                //   Scaffold.of(context)
                                                //       .showSnackBar(SnackBar(
                                                //           content: Text(
                                                //               "pic uploaded")));
                                                // });
                                              }),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  height: 30,
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
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: ElevatedButton(
                    child: Text("Update Info"),
                    onPressed: () => _showUpdatePannel()),
              ),
              // SizedBox(
              //   width: 10,
              // ),
              // ElevatedButton(
              //   child: Text("Update Profile Pic"),
              //   onPressed: () async {
              //     // to get path
              //     // String filename = basename(_image.path);
              //     // //set path
              //     // var storage = FirebaseStorage.instance.ref().child(filename);
              //     // print(storage.toString());

              //     // // upload
              //     // var upload = await storage.putFile(_image);
              //     // var url = await storage.getDownloadURL();
              //     // print("The url is hellooo" + url);
              //     // FirebaseFirestore.instance
              //     //     .collection("Employee")
              //     //     .doc(uid)
              //     //     .update({
              //     //   "profile pic": url,
              //     // });

              //     // var photo = FirebaseAuth.instance.currentUser.photoURL;
              //     // print(photo);

              //     // // FirebaseFirestore.instance
              //     // //     .collection("Employee")
              //     // //     .doc(uid)
              //     // //     .update({"profile pic": upload}).then((value) {
              //     // //   print("Update successful");
              //     // // });
              //     // // complete
              //     // setState(() {
              //     //   Scaffold.of(context)
              //     //       .showSnackBar(SnackBar(content: Text("pic uploaded")));
              //     // });
              //   },
              // )
            ]),
          ],
        ),
      ),
    );
  }
}

Widget checkprofile(String url) {
  if (url == "") {
    return Image(image: AssetImage("images/profile.jpg"));
  }
  return Image.network(url);
}
