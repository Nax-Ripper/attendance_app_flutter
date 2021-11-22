import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spring1_ui/Supervisor/DashBoard.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _fullName = TextEditingController();

  Future<bool> register(String email, String password, String name) async {
    if (_formKey.currentState!.validate()) {
      try {
        // await FirebaseAuth.instance
        //     .createUserWithEmailAndPassword(email: email, password: password);
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        User user = result.user;
        user.updateProfile(displayName: name);
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          // print("The password provided is too weak.");
          showError("The password provided is too weak.");
        } else if (e.code == "email-already-in-use") {
          // print("The account already exists for that email.");
          showError("The account already exists for that email.");
        }
        return false;
      } catch (e) {
        print(e.toString());
        showError(e.toString());
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fullName,
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Enter name";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: "Username",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      onSaved: (email) =>
                          _emailField = email as TextEditingController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordField,
                      validator: (password_input) {
                        if (password_input!.length < 6) {
                          return "Enter minimum 6 characters";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: "password",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      onSaved: (password) =>
                          _emailField = password as TextEditingController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (password) {
                        if (_passwordField.text != password) {
                          return "Password did not match";
                        } else if (password!.isEmpty) {
                          return "Enter Password";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          hintText: "password",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      onSaved: (password) =>
                          _emailField = password as TextEditingController,
                      obscureText: true,
                    ),
                  ],

                  // children: <Widget>[
                  //   inputFile(label: "Username"),
                  //   inputFile(label: "Email"),
                  //   inputFile(label: "Password", obscureText: true),
                  //   inputFile(label: "Confirm Password ", obscureText: true),
                  // ],
                ),
              ),
              Container(
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
                    bool shouldNavigate = await register(
                        _emailField.text, _passwordField.text, _fullName.text);
                    if (shouldNavigate) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    }
                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  Text(
                    " Login",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
// Widget inputFile({label, obscureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         label,
//         style: TextStyle(
//             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       TextField(
//         obscureText: obscureText,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             border:
//                 OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
//       ),
//       SizedBox(
//         height: 10,
//       )
//     ],
//   );
// }

