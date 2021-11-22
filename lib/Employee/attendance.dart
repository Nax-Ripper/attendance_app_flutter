import 'package:flutter/material.dart';


class AttendanceHistory extends StatelessWidget {
  const AttendanceHistory({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title:Text("My Attendance"),
        backgroundColor: Colors.purple,
        
      ),
    );
  }
}