import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

class RegisterUserScreen extends StatefulWidget {
  static const String routeName = "/registeruser";
  RegisterUserScreen({Key key}) : super(key: key);

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Admin",
      appBarTitleWidget: Text("Registrera"),
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Container(
          child: Container(
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Förnamn"),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "Efternamn"),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "E-post"),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "Lösenord"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.maxFinite - 30.0,
                      child: RaisedButton(
                        child: Text("Registrera", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        onPressed: () {},
                        color: Color(0xff017ACD),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
