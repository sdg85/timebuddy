import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

class MyPageScreen extends StatelessWidget {
  static const routeName = "/mypage";
  const MyPageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Min sida",
          child: Center(
        child: Text("Min sida")
      ),
    );
  }
}