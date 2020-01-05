import 'package:flutter/cupertino.dart';
import 'package:timebuddy/models/employee_shift.dart';
import 'package:timebuddy/models/shift_date.dart';

class WorkShiftProvider with ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  bool _toggleCalendar = true;

  DateTime get selectedDay => _selectedDay;

  set selectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  bool get toggleCalendar => _toggleCalendar;

  set toggleCalendar(bool toggleCalendar) {
    _toggleCalendar = toggleCalendar;
    notifyListeners();
  }

  ShiftDate getEmployeeDayShift(EmployeeShift employeeShift) {
    final date =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);

    return employeeShift.shiftDates.firstWhere((shift) {
      final shiftDate = shift.startDate;
      return DateTime(shiftDate.year, shiftDate.month, shiftDate.day) ==
          DateTime(date.year, date.month, date.day);
    }, orElse: () => null);
  }
}
