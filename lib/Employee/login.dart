import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spring1_ui/Employee/home_screen_drawer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String role = "role";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool checkEmployeeValidate(value) {
    print("This is " + value.toString());
    role = value.toString();
    try {
      if (role == "Employee") {
        return true;
      } else {
        throw Exception("You are not Employee");
      }
    } catch (Exception) {
      showError(Exception.toString());
      return false;
    }
  }

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  Future<bool> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        var usr = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        var UID = usr.user.uid;
        print(UID);
        DocumentReference docu =
            FirebaseFirestore.instance.collection("Employee").doc(UID);

        String test = "test";

        var hello = docu.get().then((value) {
          if (value.exists) {
            test = value.data()["role"];
            return test;
          }
        });

        var x = hello.then((value) => checkEmployeeValidate(value));

        return x;
      } catch (Exception) {
        print(Exception);
        showError(Exception.toString());
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 400,
                child: Image(image: AssetImage("images/login.jpg")),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            controller: _emailField,
                            validator: (Email_input) {
                              if (Email_input!.isEmpty) {
                                return "Enter Email Correctly";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: "abc123@email.com",
                            ),
                            onSaved: (email) =>
                                _emailField = email as TextEditingController,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _passwordField,
                            validator: (password_input) {
                              if (password_input!.length < 6) {
                                return "Enter minimum 6 characters";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              hintText: "password123",
                            ),
                            onSaved: (password) => _passwordField =
                                password as TextEditingController,
                            obscureText: true,
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      ),
                      child: Text(
                        "LOGIN",
                        strutStyle: StrutStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        style: TextStyle(color: Colors.greenAccent[700]),
                        // style: GoogleFonts.getFont("Lato",
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.greenAccent[700]),
                      ),
                      onPressed: () async {
                        bool shouldNavigate =
                            await signIn(_emailField.text, _passwordField.text);
                        if (shouldNavigate) {
                          Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomePage()));
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
