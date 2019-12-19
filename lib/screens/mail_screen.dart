import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

class MailScreen extends StatelessWidget {
  static const String routeName = "/mail";
  const MailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Mail",
          child: Center(
        child: Text("Mail"),
      ),
    );
  }
}