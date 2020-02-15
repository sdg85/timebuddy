import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/providers/work_shift_provider.dart';
import 'package:timebuddy/widgets/calendar.dart';
import 'package:timebuddy/widgets/layout.dart';
import 'package:timebuddy/widgets/scheduled_employees_list.dart';

class ScheduleScreen extends StatelessWidget {
  static const String routeName = "/schedule";
  final ScrollController _scrollController = ScrollController();

  ScheduleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkShiftProvider>(
      builder: (ctx, workShift, child) => Layout(
        appBarTitleWidget: InkWell(
          child: Row(
            children: <Widget>[
              Text(
                "${DateFormat.MMMM('sv_SE').format(workShift.selectedDay)[0].toUpperCase()}${DateFormat.MMMM('sv_SE').format(workShift.selectedDay).substring(1)}",
                style: TextStyle(fontSize: 18.0),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
          onTap: () {
            workShift.toggleCalendar = true;
          },
        ),
        title: "Schema",
        child: child,
      ),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Calendar(
              onTapCallback: _scrollToEnd,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10.0,
            ),
          ),
          ScheduledEmployeesList(),
        ],
      ),
    );
  }

  _scrollToEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
