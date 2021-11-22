import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Profile"),
        backgroundColor: Colors.purple,
        
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 45),
              height: 300,
              child: Image(
                image: AssetImage("images/profile.jpg"),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "Hi Mr.Anwar\n",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen),
                        )
                      ]),
                    ),
                    Text("History",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ))
                  ],
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

