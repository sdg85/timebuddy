import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:timebuddy/models/user.dart';
import 'package:timebuddy/providers/work_shift_provider.dart';
import 'package:timebuddy/routes/routes.dart';
import 'package:timebuddy/screens/admin_screen.dart';
// import 'package:timebuddy/screens/home_sceen.dart';
import 'package:timebuddy/screens/login_screen.dart';
import 'package:timebuddy/screens/mail_screen.dart';
import 'package:timebuddy/screens/schedule_screen.dart';
import 'package:timebuddy/screens/stamp_screen.dart';
import 'package:timebuddy/screens/wrapper.dart';
import 'package:timebuddy/services/auth_service.dart';

import 'screens/colleges_screen.dart';
import 'screens/mypage_screen.dart';
import 'screens/notice_of_interest_screen.dart';
import './models/user_location.dart';
import './services/location_service.dart';

void main() => runApp(MyApp());
    // initializeDateFormatting("sv_SE", null).then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthService().user),
        StreamProvider<UserLocation>.value(
            value: LocationService().locationStream),
        ChangeNotifierProvider<AuthService>.value(
          value: AuthService(),
        ),
        ChangeNotifierProvider<WorkShiftProvider>.value(
          value: WorkShiftProvider(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en'), // English
    const Locale('sv'), // Chinese
  ],
        theme: ThemeData(
          primarySwatch: MaterialColor(0xff017ACD, primaryColor),
          accentColor: MaterialColor(0xffF2F4F9, secondaryColor),
          fontFamily: "Poppins",
        ),
        routes: {
          Routes.login: (_) => LoginScreen(),
          Routes.schedule: (_) => ScheduleScreen(),
          Routes.stamp: (_) => StampScreen(),
          Routes.mail: (_) => MailScreen(),
          Routes.colleges: (_) => CollegesScreen(),
          Routes.mypage: (_) => MyPageScreen(),
          Routes.noticeOfInterest: (_) => NoticeOfInterestScreen(),
          // Routes.home: (_) => HomeScreen(),
          Routes.admin: (_) => AdminScreen()
        },
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
