import 'package:flutter/material.dart';
import 'package:timebuddy/models/shift_date.dart';

class EmployeeShift {
  String id;
  bool isAssigned;
  String name;
  List<ShiftDate> shiftDates;
  String place;
  String employeePhoto;

  EmployeeShift(
      {this.name,
      @required this.shiftDates,
      @required this.place,
      @required this.employeePhoto}) {
    isAssigned = name.trim() != null;
  }
}
