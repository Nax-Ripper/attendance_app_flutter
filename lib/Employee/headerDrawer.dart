import 'package:flutter/material.dart';
// class MyHeaderDrawer extends StatefulWidget {
//   const MyHeaderDrawer({ Key? key }) : super(key: key);

//   @override
//   _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
// }

// class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.purple,
//       width: double.infinity,
//       height: 200,
//       padding: EdgeInsets.only(top:20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Welcome",style: TextStyle(color: Colors.white,fontSize: 50),),
//           Text("Mr.Anwar",style:TextStyle(color: Colors.black,fontSize: 40) ,),
//         ],
//       )
//       ,
//     );
//   }
// }




class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   margin: EdgeInsets.only(bottom: 10),
          //   height: 70,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/profile.jpg'),
          //     ),
          //   ),
          // ),
          Text(
            "MR.Mohd Anwar Ibrahim",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "Senior Employee",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}