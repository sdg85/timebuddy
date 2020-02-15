import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timebuddy/models/work_shift.dart';
import 'package:timebuddy/widgets/circular_image.dart';

class WorkShiftCard extends StatelessWidget {
  final WorkShift employeeShift;

  const WorkShiftCard({Key key, this.employeeShift}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(15.0),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 5.0, color: Colors.orange),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(children: [
                    SizedBox(
                      width: 80.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${employeeShift.firstName} ${employeeShift.lastName}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15.0),
                        ),
                        Text(
                          "${DateFormat('HH:mm').format(employeeShift.startShiftDate)} - ${DateFormat('HH:mm').format(employeeShift.endShiftDate)}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/map.png",
                        height: 15.0,
                        width: 15.0,
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      Text(
                        employeeShift.place,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Image.asset("assets/images/coffee.png",
                            height: 15.0, width: 15.0),
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      Text(
                        "${DateFormat('HH:mm').format(employeeShift.restStart)} - ${DateFormat('HH:mm').format(employeeShift.restEnd)}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: -1.0,
            left: 30.0,
            child: CircularImage(
              imagePath: employeeShift.employeePhoto,
            ))
      ],
    );
  }
}
