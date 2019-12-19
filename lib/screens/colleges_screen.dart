import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

class CollegesScreen extends StatelessWidget {
  static const String routeName = "/colleges";
  const CollegesScreen({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Layout(
      title: "Kollegor",
          child: Center(
        child: Text("Kollegor"),
      ),
    );
  }
}