import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:timebuddy/models/work_shift.dart';
import 'package:timebuddy/services/work_shift_service.dart';

class WorkShiftProvider with ChangeNotifier {
  //private properties
  DateTime _selectedDay = DateTime.now();
  bool _toggleCalendar = true;
  bool _isLoading;
  Map<DateTime, List<dynamic>> _allWorkShiftsByMonth =
      Map<DateTime, List<dynamic>>();
  Map<DateTime, List<dynamic>> _userWorkShiftsByMonth =
      Map<DateTime, List<dynamic>>();
  List<WorkShift> _selectedDayWorkShifts = List<WorkShift>();
  final _workshiftsDb = Firestore.instance.collection("work_shift");
  WorkShiftService _service = WorkShiftService();

  //get spinner
  get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  //get selected day date
  DateTime get selectedDay => _selectedDay;

  //set the date of the selected date
  set selectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    isLoading = true;
    getWorkShiftsByDay(_selectedDay).whenComplete(() {
      isLoading = false;
      if (_selectedDayWorkShifts.length > 0) _toggleCalendar = !toggleCalendar;

      notifyListeners();
    });
  }

  //getter property for the selected day work shifts
  List<WorkShift> get selectedDayWorkShifts => _selectedDayWorkShifts;

  //setter property for the selected day work shifts
  set selectedDayWorkShifts(List<WorkShift> workShifts) {
    _selectedDayWorkShifts = workShifts;
    notifyListeners();
  }

  //this shows or hides the calendar
  bool get toggleCalendar => _toggleCalendar;

  set toggleCalendar(bool toggleCalendar) {
    _toggleCalendar = toggleCalendar;
    notifyListeners();
  }

  //getter property that holds the work shifts of a month
  Map<DateTime, List<dynamic>> get allWorkShiftstByMonth =>
      _allWorkShiftsByMonth;

  //setter property that sets the work shifts of a month
  set allWorkShiftstByMonth(Map<DateTime, List<dynamic>> events) {
    _allWorkShiftsByMonth = events;
    notifyListeners();
  }

  //getter for user workshifts by month
  Map<DateTime, List<dynamic>> get userWorkShiftsByMonth =>
      _userWorkShiftsByMonth;

  //setter for user workshifts by month
  set userWorkShiftsByMonth(Map<DateTime, List<dynamic>> events) {
    _userWorkShiftsByMonth = events;
    notifyListeners();
  }

//--------------------------------functions--------------------------------------//

  //get work shift of a user by month
  void getUserWorkShiftsByMonth(String userId, DateTime date) async {
    final events = Map<DateTime, List<dynamic>>();
    final period = DateFormat("yyyyMM").format(date);

    final listOfDocumentSnapshot = (await _workshiftsDb
            .where("employeeId", isEqualTo: userId)
            .where("period", isEqualTo: period)
            .getDocuments())
        .documents
        .toList();

    for (var ds in listOfDocumentSnapshot) {
      final DateTime shiftDate = ds["startShiftDate"].toDate();
      final date = DateTime.parse(DateFormat("yyyy-MM-dd").format(shiftDate));

      events[date] = [];
    }
    userWorkShiftsByMonth = events;
  }

  //get work shifts of given month and set them to "allWorkShiftsByMonth" property
  void getWorkShiftsOfTheMonth(DateTime date) async {
    final events = Map<DateTime, List<dynamic>>();
    await _service.getAllWorkShiftsByMonth(date).then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        final DateTime shiftDate = doc["startShiftDate"].toDate();
        final date = DateTime.parse(DateFormat("yyyy-MM-dd").format(shiftDate));
        events[date] = [];
      });
    }).catchError((error) => print(error));
    allWorkShiftstByMonth = events;
  }

  Future getWorkShiftsByDay(DateTime date) async {
    if(date == null)
      date = DateTime(1970, 01, 01);
      
    final customDate = DateTime(date.year, date.month, date.day, 0, 0);

    //check if there is workshifts on this day by checking with workshifts of month
    if (!_userWorkShiftsByMonth.containsKey(customDate)) {
      _selectedDayWorkShifts = List<WorkShift>();
      return;
    }

    print("getWorkShiftsByDay called!");
    final result = await _service.getWorkShiftsByDay(customDate);

    _selectedDayWorkShifts = result.documents
        .map(
          (ds) => WorkShift(
            id: ds.documentID,
            startShiftDate: ds.data["startShiftDate"].toDate(),
            endShiftDate: ds.data["endShiftDate"].toDate(),
            restStart: ds.data["restStart"].toDate(),
            place: ds.data["place"],
            employeePhoto: ds.data["photoUrl"],
            restEnd: ds.data["restEnd"].toDate(),
            name: ds.data["name"],
          ),
        )
        .toList();
  }
}
