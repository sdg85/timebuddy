import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

class StampScreen extends StatelessWidget {
  static const String routeName = "/stamp";
  const StampScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Tid",
          child: Center(
        child: Text("Tid")
      ),
    );
  }
}