import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/models/employee_shift.dart';
import 'package:timebuddy/providers/work_shift_provider.dart';

class WorkShiftCard extends StatelessWidget {
  final EmployeeShift employeeShift;

  const WorkShiftCard({Key key, this.employeeShift}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WorkShiftProvider provider = Provider.of<WorkShiftProvider>(context);
    final shift = provider.getEmployeeDayShift(employeeShift);

    return Stack(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 30),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 5.0, color: Colors.orange),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: [
                  SizedBox(
                    width: 80.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${employeeShift.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15.0),
                      ),
                      Text(
                        "${DateFormat('HH:mm').format(shift.startDate)} - ${DateFormat('HH:mm').format(shift.endDate)}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                ]),
                SizedBox(height: 15.0,),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      size: 18.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      employeeShift.place,
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Icon(
                      Icons.local_cafe,
                      size: 18.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "${DateFormat('HH:mm').format(shift.restStart)} - ${DateFormat('HH:mm').format(shift.restEnd)}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: 15.0,
        left: 14.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            employeeShift.employeePhoto,
            height: 70.0,
            width: 70.0,
          ),
        ),
      )
    ]);
  }
}
