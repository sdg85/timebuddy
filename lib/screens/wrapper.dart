import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/models/user.dart';
import 'package:timebuddy/screens/login_screen.dart';
import 'package:timebuddy/screens/schedule_screen.dart';

class Wrapper extends StatelessWidget {
  static const String routeName = "/home";
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user != null ? ScheduleScreen() : LoginScreen();
  }
}