import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/models/user.dart';
import 'package:timebuddy/screens/home_sceen.dart';
import 'package:timebuddy/screens/login_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user != null ? HomeScreen() : LoginScreen();
  }
}