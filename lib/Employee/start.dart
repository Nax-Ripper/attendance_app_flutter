import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:spring1_ui/Employee/login.dart';
import 'package:spring1_ui/Employee/signup.dart';

class start extends StatefulWidget {
  const start({Key? key}) : super(key: key);

  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Container(
                height: 300,
                child: Image(
                  image: AssetImage("images/clock.jpg"),
                )),
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Employee",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent[700]),
                )
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\n",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.only(left: 30, right: 30),
                    ),
                    child: Text(
                      "LOGIN",
                      strutStyle: StrutStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      style: TextStyle(color: Colors.greenAccent[700]),
                      // style:
                      // GoogleFonts.getFont("Lato",
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.greenAccent[700]),
                    ),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Login()));
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Login()));
                      });
                    }),
                SizedBox(
                  width: 20,
                  height: 50,
                ),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.black,
                //       padding: EdgeInsets.only(left: 30, right: 30),
                //     ),
                //     child: Text(
                //       "SIGNUP",
                //       strutStyle: StrutStyle(fontWeight: FontWeight.bold,),style: TextStyle(color: Colors.greenAccent[700]),
                //       // style: GoogleFonts.getFont("Lato",
                //       //     fontWeight: FontWeight.bold,
                //       //     color: Colors.greenAccent[700]),
                //     ),
                //     onPressed: () {
                //       //  Navigator.push(context,
                //       //     MaterialPageRoute(builder: (context) => SignUp()));
                //       WidgetsBinding.instance!.addPostFrameCallback((_) {
                //         Navigator.pushReplacement(context,
                //             MaterialPageRoute(builder: (_) => SignUp()));
                //       });
                //     }),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
