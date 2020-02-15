import 'package:flutter/material.dart';

class WorkShift {
  String id;
  String firstName;
  String lastName;
  DateTime startShiftDate;
  DateTime endShiftDate;
  DateTime restStart;
  DateTime restEnd;
  String place;
  String employeePhoto;

  WorkShift({
      @required id,
      this.firstName,
      this.lastName,
      @required this.startShiftDate,
      @required this.endShiftDate,
      this.restStart,
      this.restEnd,
      @required this.place,
      this.employeePhoto
      });

  // factory WorkShift.fromMap(Map data){
  //   data = data ?? {};

  //   return WorkShift(
      
  //   )
  // }
}
