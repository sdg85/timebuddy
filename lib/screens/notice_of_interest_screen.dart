import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

class NoticeOfInterestScreen extends StatelessWidget {
  static const String routeName = "/noticeofinterest";
  const NoticeOfInterestScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Intresseanmälan",
          child: Center(
        child: Text("Intresseanmälan"),
      ),
    );
  }
}