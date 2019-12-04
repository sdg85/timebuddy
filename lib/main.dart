import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/models/user.dart';
import 'package:timebuddy/screens/wrapper.dart';
import 'package:timebuddy/services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        title: 'Flutter Demo',
        home: Wrapper(),
      ),
    );
  }
}
