import 'package:flutter/material.dart';

class WorkShift {
  String id;
  String employeeId;
  String name;
  String date;
  DateTime startShiftDate;
  DateTime endShiftDate;
  DateTime restStart;
  DateTime restEnd;
  String place;
  String employeePhoto;
  String period;
  bool isAssigned;

  WorkShift(
      {this.id,
      this.name,
      this.date,
      @required this.startShiftDate,
      @required this.endShiftDate,
      this.restStart,
      this.restEnd,
      @required this.place,
      this.period,
      this.employeeId,
      this.isAssigned,
      this.employeePhoto});

  WorkShift.fromData(Map<String, dynamic> data)
      : employeeId = data["employeeId"],
        date = data["date"],
        name = data["name"],
        startShiftDate = data["startShiftDate"],
        endShiftDate = data["endShiftDate"],
        restStart = data["restStart"],
        restEnd = data["restEnd"],
        place = data["place"],
        employeePhoto = data["photoUrl"],
        period = data["period"],
        isAssigned = data["isAssigned"];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'startShiftDate': startShiftDate,
      'endShiftDate': endShiftDate,
      'restStart': restStart,
      'restEnd': restEnd,
      'place': place,
      'period': period,
      'employeeId': employeeId,
      'isAssigned': isAssigned,
      'photoUrl': employeePhoto
    };
  }
}
