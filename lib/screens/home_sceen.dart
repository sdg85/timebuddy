import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';
import "../services/auth_service.dart";

class HomeScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Home",
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "WELCOME TO HOME SCREEN!",
                style: TextStyle(
                  color: Colors.blue[300],
                ),
              ),
              FlatButton(child: Text("logout"),
              onPressed: () async {
                await auth.signOut();
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}
