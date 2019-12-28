import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/models/employee_shift.dart';
import 'package:timebuddy/models/shift_date.dart';
import 'package:timebuddy/providers/work_shift_provider.dart';
import 'package:timebuddy/widgets/work_shift_card.dart';

class ScheduledEmployeesList extends StatelessWidget {
  final List<EmployeeShift> employees = [
    EmployeeShift(
        name: "Antonio Rodriguez",
        shiftDates: [
          ShiftDate(
            startDate: DateTime(2019, 12, 19, 8, 0),
            endDate: DateTime(2019, 12, 19, 17, 0),
            restStart: DateTime(2019, 12, 19, 12, 0),
            restEnd: DateTime(2019, 12, 19, 13, 0),
          ),
        ],
        place: "Elgiganten Jönköping",
        employeePhoto:
            "https://randomuser.me/api/portraits/women/19.jpg"),
    EmployeeShift(
        name: "Antonio Rodriguez",
        shiftDates: [
          ShiftDate(
            startDate: DateTime(2019, 12, 19, 12, 0),
            endDate: DateTime(2019, 12, 19, 17, 0),
            restStart: DateTime(2019, 12, 19, 14, 0),
            restEnd: DateTime(2019, 12, 19, 14, 30),
          ),
        ],
        place: "Elgiganten Jönköping",
        employeePhoto: "https://randomuser.me/api/portraits/men/43.jpg"),
    EmployeeShift(
        name: "Antonio Rodriguez",
        shiftDates: [
          ShiftDate(
            startDate: DateTime(2019, 12, 16, 8, 0),
            endDate: DateTime(2019, 12, 16, 17, 0),
            restStart: DateTime(2019, 12, 16, 12, 0),
            restEnd: DateTime(2019, 12, 16, 13, 0),
          ),
          ShiftDate(
            startDate: DateTime(2019, 12, 17, 8, 0),
            endDate: DateTime(2019, 12, 17, 17, 0),
            restStart: DateTime(2019, 12, 17, 12, 0),
            restEnd: DateTime(2019, 12, 17, 13, 0),
          ),
          ShiftDate(
            startDate: DateTime(2019, 12, 18, 8, 0),
            endDate: DateTime(2019, 12, 18, 17, 0),
            restStart: DateTime(2019, 12, 18, 12, 0),
            restEnd: DateTime(2019, 12, 18, 13, 0),
          ),
        ],
        place: "Elgiganten Jönköping",
        employeePhoto:
            "https://randomuser.me/api/portraits/men/91.jpg"),
    EmployeeShift(
        name: "Antonio Rodriguez",
        shiftDates: [
          ShiftDate(
            startDate: DateTime(2019, 12, 16, 12, 0),
            endDate: DateTime(2019, 12, 16, 17, 0),
            restStart: DateTime(2019, 12, 16, 14, 0),
            restEnd: DateTime(2019, 12, 16, 14, 30),
          ),
          ShiftDate(
            startDate: DateTime(2019, 12, 17, 12, 0),
            endDate: DateTime(2019, 12, 17, 17, 0),
            restStart: DateTime(2019, 12, 17, 14, 0),
            restEnd: DateTime(2019, 12, 17, 14, 30),
          ),
          ShiftDate(
            startDate: DateTime(2019, 12, 18, 12, 0),
            endDate: DateTime(2019, 12, 18, 17, 0),
            restStart: DateTime(2019, 12, 18, 14, 0),
            restEnd: DateTime(2019, 12, 18, 14, 30),
          ),
        ],
        place: "Elgiganten Jönköping",
        employeePhoto:
            "https://randomuser.me/api/portraits/men/46.jpg"),
    EmployeeShift(
        name: "Antonio Rodriguez",
        shiftDates: [
          ShiftDate(
            startDate: DateTime(2019, 12, 19, 8, 0),
            endDate: DateTime(2019, 12, 19, 17, 0),
            restStart: DateTime(2019, 12, 19, 12, 0),
            restEnd: DateTime(2019, 12, 19, 13, 0),
          ),
        ],
        place: "Elgiganten Jönköping",
        employeePhoto:
            "https://randomuser.me/api/portraits/men/26.jpg"),
    EmployeeShift(
        name: "Antonio Rodriguez",
        shiftDates: [
          ShiftDate(
            startDate: DateTime(2019, 12, 26, 8, 0),
            endDate: DateTime(2019, 12, 26, 17, 0),
            restStart: DateTime(2019, 12, 26, 12, 0),
            restEnd: DateTime(2019, 12, 26, 13, 0),
          ),
        ],
        place: "Elgiganten Jönköping",
        employeePhoto:
            "https://randomuser.me/api/portraits/women/58.jpg"),
    EmployeeShift(
        name: "Antonio Rodriguez",
        shiftDates: [
          ShiftDate(
            startDate: DateTime(2019, 12, 26, 12, 0),
            endDate: DateTime(2019, 12, 26, 17, 0),
            restStart: DateTime(2019, 12, 26, 14, 0),
            restEnd: DateTime(2019, 12, 26, 14, 30),
          ),
        ],
        place: "Elgiganten Jönköping",
        employeePhoto: "https://randomuser.me/api/portraits/women/56.jpg"),
  ];

  ScheduledEmployeesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkShiftProvider provider = Provider.of<WorkShiftProvider>(context);

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final employee  = employees[index];

        final shift = provider.getEmployeeDayShift(employee);

        return shift != null
            ? WorkShiftCard(
                employeeShift: employee,
              )
            : SizedBox();
      }, childCount: employees.length),
    );
  }
}
