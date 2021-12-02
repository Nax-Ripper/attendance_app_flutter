import 'package:flutter/material.dart';
import 'package:spring1_ui/Supervisor/addemployee.dart';
import 'package:spring1_ui/Supervisor/info.dart';
import 'package:spring1_ui/Supervisor/profile.dart';
import 'package:spring1_ui/Supervisor/listofemployee.dart';
import 'package:spring1_ui/WelcomeScr.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new MaterialButton(
                    elevation: 10,
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Profile"),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      )
                    },
                    splashColor: Colors.redAccent,
                  )),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new MaterialButton(
                    elevation: 10,
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Attendance"),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Attendance()),
                      )
                    },
                    splashColor: Colors.redAccent,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new MaterialButton(
                    elevation: 10,
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Logout"),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      )
                    },
                    splashColor: Colors.redAccent,
                  )),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new MaterialButton(
                    elevation: 10,
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("About"),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      )
                    },
                    splashColor: Colors.redAccent,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new MaterialButton(
                    
                    elevation: 10,
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Add Employee"),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddEmployee()),
                      )
                    },
                    splashColor: Colors.redAccent,
                  )),
            ],
          )
        ],
      )),
    );
  }
}
