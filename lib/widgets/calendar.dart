import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timebuddy/providers/work_shift_provider.dart';

class Calendar extends StatefulWidget {
  static const routeName = "/schedule";
  final VoidCallback onTapCallback;

  Calendar({Key key, this.onTapCallback}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final _calendarcontroller = CalendarController();
  DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkShiftProvider>(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: provider.toggleCalendar ? 450.0 : 0.0,
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedDate = DateTime(
                            _selectedDate.year, _selectedDate.month - 1);
                        provider.selectedDay = _selectedDate;
                        _calendarcontroller.setSelectedDay(_selectedDate);
                      });
                    },
                  ),
                  Text(
                    "${DateFormat.MMMM('sv_SE').format(_selectedDate)[0].toUpperCase()}${DateFormat.MMMM('sv_SE').format(_selectedDate).substring(1)} ${DateFormat.y().format(_selectedDate)}",
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedDate = DateTime(
                            _selectedDate.year, _selectedDate.month + 1);
                        provider.selectedDay = _selectedDate;
                        _calendarcontroller.setSelectedDay(_selectedDate);
                      });
                    },
                  ),
                ],
              ),
            ),
            TableCalendar(
              headerVisible: false,
              calendarController: _calendarcontroller,
              onVisibleDaysChanged: (d, dt, cf) {
                setState(() {
                  print("onVisibleDaysChanged!");
                  _selectedDate = d;
                  provider.selectedDay = _selectedDate;
                  _calendarcontroller.setSelectedDay(d);
                });
              },
              initialSelectedDay: _selectedDate,
              locale: 'sv_SE',
              initialCalendarFormat: CalendarFormat.month,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                dowTextBuilder: (date, locale) {
                  return DateFormat.E(locale)
                      .format(date)
                      .substring(0, 3)
                      .toUpperCase();
                },
              ),
              formatAnimation: FormatAnimation.slide,
              startingDayOfWeek: StartingDayOfWeek.monday,
              availableGestures: AvailableGestures.horizontalSwipe,
              builders: CalendarBuilders(
                dayBuilder: (context, date, list) {
                  return _calendarDayCell(date, false);
                },
                selectedDayBuilder: (context, date, list) {
                  return _calendarDayCell(date, true);
                },
                markersBuilder: (context, date, listA, listB) {
                  print(date.toString() + "\n" + _selectedDate.toString());
                  return [
                    Positioned(
                      top: 35.0,
                      child: Container(
                          height: 5.0,
                          width: 5.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: DateTime(
                                              _selectedDate.year,
                                              _selectedDate.month,
                                              _selectedDate.day)
                                          .compareTo(DateTime(date.year,
                                              date.month, date.day)) ==
                                      0
                                  ? Colors.white
                                  : Colors.blue)),
                    )
                  ];
                },
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
              ),
              onDaySelected: (DateTime date, List events) {
                setState(() {
                  _selectedDate = date;
                  provider.selectedDay = _selectedDate;
                  provider.toggleCalendar = !provider.toggleCalendar;
                });
              },
              events: {
                DateTime.now(): [1, 2, 3, 4, 5],
                DateTime(2020, 1, 3): [],
                DateTime(2020, 1, 4): [],
                DateTime(2020, 1, 6): [],
                DateTime(2020, 1, 7): [],
                DateTime(2020, 1, 10): [],
                DateTime(2020, 1, 13): [],
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _calendarDayCell(DateTime date, bool selectedDate) {
  return Center(
    child: Container(
      width: date.weekday == 7 && date.day == 1 ||
              date.weekday == 1 &&
                  date.day == DateTime(date.year, date.month + 1, 0).day
          ? 38
          : 55,
      height: 33,
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: _generateBorderRadius(date)),
      child: Center(
        child: selectedDate
            ? Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            : Text(
                date.day.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
      ),
    ),
  );
}

BorderRadius _generateBorderRadius(DateTime date) {
  return date.weekday == 7 && date.day == 1
      ? BorderRadius.horizontal(
          left: Radius.circular(40), right: Radius.circular(40))
      : date.day == 1 && date.weekday != 7
          ? BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
          : date.weekday == 1 &&
                  date.day == DateTime(date.year, date.month + 1, 0).day
              ? BorderRadius.all(Radius.circular(20))
              : date.weekday == 7 ||
                      date.day == DateTime(date.year, date.month + 1, 0).day
                  ? BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))
                  : date.weekday == 1
                      ? BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))
                      : null;
}
