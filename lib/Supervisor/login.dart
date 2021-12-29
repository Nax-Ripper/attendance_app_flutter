import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spring1_ui/Supervisor/DashBoard.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String role = "role";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  bool checkSupervisorValidate(value) {
    print("This is " + value.toString());
    role = value.toString();
    try {
      if (role == "Supervisor") {
        return true;
      } else {
        throw Exception("You are not Supervisor");
      }
    } catch (Exception) {
      showError(Exception.toString());
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        var usr = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        var UID = usr.user.uid;
        print(UID);
        DocumentReference docu =
            FirebaseFirestore.instance.collection("Supervisor").doc(UID);

        String test = "test";

        var hello = docu.get().then((value) {
          if (value.exists) {
            test = value.data()["role"];
            return test;
          }
        });

        var x = hello.then((value) => checkSupervisorValidate(value));

        return x;

        return true;
      } catch (exception) {
        print(exception);
        showError(exception.toString());
        return false;
      }
    }
    return false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),

                ///////////______________________________///////////////////

                Container(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return "Enter Email";
                                }
                              },
                              controller: _emailField,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email_outlined),
                                  hintText: "abc123@email.com",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              onSaved: (email) =>
                                  _emailField = email as TextEditingController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              // input field
                              validator: (password) {
                                if (password!.length < 6) {
                                  return "Provide Minimum 6 Character";
                                }
                              },
                              controller: _passwordField,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.lock_outline),
                                  hintText: "password",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                              onSaved: (password) => _passwordField =
                                  password as TextEditingController,
                              obscureText: true,
                            ),
                          ],
                        ),
                      )),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        bool shouldNavigate = await signIn(_emailField.text,
                            _passwordField.text); //-----> call sign in func
                        if (shouldNavigate) {
                          Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        }
                      },
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    Text(
                      " Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
