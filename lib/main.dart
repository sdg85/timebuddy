import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/models/user.dart';
import 'package:timebuddy/screens/wrapper.dart';
import 'package:timebuddy/services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<User>.value(
      value: AuthService().user),
      ChangeNotifierProvider<AuthService>.value(
        value: AuthService(),
      )
    ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: MaterialColor(0xff017ACD, primaryColor),
          accentColor: MaterialColor(0xffF2F4F9, secondaryColor),
          fontFamily: "Poppins",
        ),
        title: 'Flutter Demo',
        home: Wrapper(),
      ),
    );
  }
}

//primary color
final Map<int, Color> primaryColor = {
  50: Color.fromRGBO(1, 122, 205, 0.1),
  100: Color.fromRGBO(1, 122, 205, 0.2),
  200: Color.fromRGBO(1, 122, 205, 0.3),
  300: Color.fromRGBO(1, 122, 205, 0.4),
  400: Color.fromRGBO(1, 122, 205, 0.5),
  500: Color.fromRGBO(1, 122, 205, 0.6),
  600: Color.fromRGBO(1, 122, 205, 0.7),
  700: Color.fromRGBO(1, 122, 205, 0.8),
  800: Color.fromRGBO(1, 122, 205, 0.9),
  900: Color.fromRGBO(1, 122, 205, 1),
};

//secondary color
final Map<int, Color> secondaryColor = {
  50: Color.fromRGBO(242, 244, 249, 0.1),
  100: Color.fromRGBO(242, 244, 249, 0.2),
  200: Color.fromRGBO(242, 244, 249, 0.3),
  300: Color.fromRGBO(242, 244, 249, 0.4),
  400: Color.fromRGBO(242, 244, 249, 0.5),
  500: Color.fromRGBO(242, 244, 249, 0.6),
  600: Color.fromRGBO(242, 244, 249, 0.7),
  700: Color.fromRGBO(242, 244, 249, 0.8),
  800: Color.fromRGBO(242, 244, 249, 0.9),
  900: Color.fromRGBO(242, 244, 249, 1),
};