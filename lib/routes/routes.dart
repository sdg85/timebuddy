import 'package:timebuddy/screens/admin_screen.dart';
import 'package:timebuddy/screens/colleges_screen.dart';
import 'package:timebuddy/screens/login_screen.dart';
import 'package:timebuddy/screens/mail_screen.dart';
import 'package:timebuddy/screens/mypage_screen.dart';
import 'package:timebuddy/screens/notice_of_interest_screen.dart';
import 'package:timebuddy/screens/register_user_screen.dart';
import 'package:timebuddy/screens/schedule_screen.dart';
import 'package:timebuddy/screens/stamp_screen.dart';
import 'package:timebuddy/screens/work_shift_detail_screen.dart';

class Routes {

  static const String schedule = ScheduleScreen.routeName;
  static const String login = LoginScreen.routeName;
  static const String stamp = StampScreen.routeName;
  static const String mail = MailScreen.routeName;
  static const String colleges = CollegesScreen.routeName;
  static const String mypage = MyPageScreen.routeName;
  static const String noticeOfInterest = NoticeOfInterestScreen.routeName;
  static const String home = NoticeOfInterestScreen.routeName;
  static const String workShiftDetail = WorkShiftDetailScreen.routeName;
  static const String registerUser = RegisterUserScreen.routeName;
  static const String admin = AdminScreen.routeName;
}