import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timebuddy/models/user.dart';
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
  Map<DateTime, List<dynamic>> events;
  GlobalKey _calendarWidgetKey = GlobalKey();
  double calendarHeight;

  _getWidgetHeightSize() {
    RenderBox _calendarBox =
        _calendarWidgetKey.currentContext.findRenderObject();
    calendarHeight = _calendarBox.size.height;
    print("Height: $calendarHeight");
  }

  @override
  void initState() {
    // _selectedDate = DateTime(2020, 03,01);
    _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getWidgetHeightSize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Provider.of<WorkShiftProvider>(context, listen: false)
        .getUserWorkShiftsByMonth(user.id, _selectedDate);

    return Consumer<WorkShiftProvider>(
      builder: (context, workShift, child) => AnimatedContainer(
        key: _calendarWidgetKey,
        duration: Duration(milliseconds: 300),
        // height: workShift.toggleCalendar ? calendarHeight : 0.0,
        height: workShift.toggleCalendar ? MediaQuery.of(context).size.height * 53 / 100 : 0.0,
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedDate = DateTime(
                                  _selectedDate.year, _selectedDate.month - 1);
                              workShift.selectedDay = _selectedDate;
                              _calendarcontroller.setSelectedDay(_selectedDate);
                            });
                          },
                        ),
                        Text(
                          "${DateFormat.MMMM('sv_SE').format(_selectedDate)[0].toUpperCase()}${DateFormat.MMMM('sv_SE').format(_selectedDate).substring(1)} ${DateFormat.y().format(_selectedDate)}",
                          style: TextStyle(
                              color: Colors.blue[600],
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedDate = DateTime(
                                  _selectedDate.year, _selectedDate.month + 1);
                              workShift.selectedDay = _selectedDate;
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
                        _selectedDate = d;
                        workShift.selectedDay = _selectedDate;
                        _calendarcontroller.setSelectedDay(d);
                      });
                    },
                    initialSelectedDay: _selectedDate,
                    locale: 'sv_SE',
                    initialCalendarFormat: CalendarFormat.month,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      weekdayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                      dowTextBuilder: (date, locale) {
                        return DateFormat.E(locale)
                            .format(date)
                            .substring(0, 3)
                            .toUpperCase();
                      },
                    ),
                    rowHeight: 43.0,
                    formatAnimation: FormatAnimation.slide,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    availableGestures: AvailableGestures.horizontalSwipe,
                    builders: CalendarBuilders(
                      todayDayBuilder: (context, date, list) {
                        return _calendarDayCell(date, false, true);
                      },
                      dayBuilder: (context, date, list) {
                        return _calendarDayCell(date, false, false);
                      },
                      selectedDayBuilder: (context, date, list) {
                        return _calendarDayCell(date, true, false);
                      },
                      markersBuilder: (context, date, listA, listB) {
                        return [
                          Positioned(
                            top: 29.0,
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
                      _selectedDate = date;
                      workShift.selectedDay = _selectedDate;
                    },
                    events: workShift.userWorkShiftsByMonth,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

Widget _calendarDayCell(DateTime date, bool selectedDate, bool today) {
  return Center(
    child: Container(
      width: date.weekday == 7 && date.day == 1 ||
              date.weekday == 1 &&
                  date.day == DateTime(date.year, date.month + 1, 0).day
          ? 34
          : 51,
      height: 31,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: _generateBorderRadius(date),
      ),
      child: Center(
        child: selectedDate
            ? Container(
                width: 32,
                height: 32,
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
            : today
                ? Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : Text(
                    date.day.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
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
