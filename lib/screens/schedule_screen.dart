import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

class ScheduleScreen extends StatelessWidget {
  static const routeName = "/schedule";
  const ScheduleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Schema",
      child: Center(
        child: Text("Schema"),
      ),
    );
  }
}
