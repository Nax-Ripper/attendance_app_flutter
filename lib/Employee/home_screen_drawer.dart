import 'package:flutter/material.dart';
import 'package:spring1_ui/Employee/attendance.dart';
import 'package:spring1_ui/Employee/finance.dart';
import 'package:spring1_ui/Employee/home_screen.dart';
import 'package:spring1_ui/main.dart';
import 'package:spring1_ui/Employee/profilepage.dart';

import 'headerDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.home) {
      container = HomeScreen();
    } else if (currentPage == DrawerSections.profile) {
      container = ProfilePage();
    } else if (currentPage == DrawerSections.income) {
      container = IncomePage();
    } else if (currentPage == DrawerSections.attendance) {
      container = AttendanceHistory();
    } else if (currentPage == DrawerSections.logout) {
      // container = start();
      // Navigator.push(context, (MaterialPageRoute(builder:(context)=>start())));
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MyApp()));
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Profile", Icons.person,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(3, "Finance", Icons.monetization_on,
              currentPage == DrawerSections.income ? true : false),
          menuItem(4, "Attendance", Icons.timer,
              currentPage == DrawerSections.attendance ? true : false),
          Divider(),
          menuItem(5, "Logout", Icons.lock_open_rounded,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.profile;
            } else if (id == 3) {
              currentPage = DrawerSections.income;
            } else if (id == 4) {
              currentPage = DrawerSections.attendance;
            } else if (id == 5) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  home,
  profile,
  income,
  attendance,
  logout,
}
