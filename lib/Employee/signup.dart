// import 'package:flutter/material.dart';
// import 'package:spring1_ui/Employee/home_screen_drawer.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 height: 300,
//                 child: Image(image: AssetImage("images/signup.gif")),
//               ),
//               Container(
//                 child: Form(
//                     child: Column(
//                   children: [
//                     Container(
//                       child: TextFormField(
//                         validator: (Full_name) {
//                           if (Full_name!.isEmpty) {
//                             return "Enter Name Correctly";
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Full Name",
//                           prefixIcon: Icon(Icons.person),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       child: TextFormField(
//                         validator: (Email_input) {
//                           if (Email_input!.isEmpty) {
//                             return "Enter Email Correctly";
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Email",
//                           prefixIcon: Icon(Icons.email_outlined),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       child: TextFormField(
//                         validator: (password_input) {
//                           if (password_input!.length < 6) {
//                             return "Enter minimum 6 characters";
//                           }
//                         },
//                         decoration: InputDecoration(
//                             labelText: "Password",
//                             prefixIcon: Icon(Icons.lock_outline_rounded)),
//                         obscureText: true,
//                       ),
//                     )
//                   ],
//                 )),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.black,
//                         onPrimary: Colors.white,
//                         padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
//                       ),
//                       child: Text(
//                         "SIGNUP",
//                         strutStyle: StrutStyle(fontWeight: FontWeight.bold,),style: TextStyle(color: Colors.greenAccent[700]),
//                         // style: GoogleFonts.getFont("Lato",
//                         //     fontWeight: FontWeight.bold,
//                         //     color: Colors.greenAccent[700]),
//                       ),
//                       onPressed: () {
//                         //  Navigator.push(context,
//                         //   MaterialPageRoute(builder: (context) => HomePage()));
//                         WidgetsBinding.instance!.addPostFrameCallback((_) {
//                           Navigator.pushReplacement(context,
//                               MaterialPageRoute(builder: (_) => HomePage()));
//                         });
//                       }),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
