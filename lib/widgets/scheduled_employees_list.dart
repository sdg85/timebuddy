import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/providers/work_shift_provider.dart';
import 'package:timebuddy/screens/work_shift_detail_screen.dart';
import 'package:timebuddy/widgets/work_shift_card.dart';

class ScheduledEmployeesList extends StatelessWidget {
  ScheduledEmployeesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkShiftProvider>(context);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final workShift = provider.selectedDayWorkShifts[index];
          return Hero(
            tag: workShift.name,
            transitionOnUserGestures: true,
            flightShuttleBuilder: (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
            ) {
              return SingleChildScrollView(
                child: fromHeroContext.widget,
              );
            },
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => WorkShiftDetailScreen(workShift: workShift),
                            ),
                  );
                },
                child: WorkShiftCard(
                  employeeShift: workShift,
                ),
              ),
            ),
          );
        },
        childCount: provider.selectedDayWorkShifts.length,
      ),
    );
  }
}
