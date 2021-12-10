import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:spring1_ui/Supervisor/home.dart';
import 'package:spring1_ui/Supervisor/login.dart';

class verifyPage extends StatefulWidget {
  @override
  _verifyPageState createState() => _verifyPageState();
}

class _verifyPageState extends State<verifyPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void sendOTP() async {
    EmailAuth.sessionName = "Test Session";
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("OTP Sent");
    } else {
      print("we couldn't sent the OTP");
    }
  }

  void verifyOTP() {
    var res = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("OTP Verified");
    } else {
      print("Invalid OTP");
    }
  }

  void showDialog() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Verify Email"),
      ),
      body: Column(
        children: [
          Image.asset(
            "images/email.png",
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Enter email",
                      labelText: "Email",
                      suffixIcon: TextButton(
                        child: Text("Send OTP"),
                        onPressed: () => sendOTP(),
                      )),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter OTP",
                    labelText: "OTP",
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                    child: Text("Verify OTP"), onPressed: () => verifyOTP()),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                    child: Text("Login"),
                    onPressed: () {
                      var res = EmailAuth.validate(
                          receiverMail: _emailController.text,
                          userOTP: _otpController.text);
                      if (res) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      } else {
                        print("Invalid OTP");
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
