import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/calendar.dart';
import 'package:timebuddy/widgets/layout.dart';
import 'package:timebuddy/widgets/scheduled_employees_list.dart';

class ScheduleScreen extends StatelessWidget {
  static const String routeName = "/schedule";
  const ScheduleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Schema",
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Calendar(),
          ),
          ScheduledEmployeesList()
        ],
      ),
    );
  }
}
