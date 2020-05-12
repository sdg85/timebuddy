import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:timebuddy/models/user.dart';
import 'package:timebuddy/models/work_shift.dart';
import 'package:timebuddy/services/firestore_service.dart';
import 'package:timebuddy/widgets/circular_image.dart';
import 'package:timebuddy/widgets/in_progress_loader.dart';

class WorkShiftForm extends StatefulWidget {
  WorkShiftForm({Key key}) : super(key: key);

  @override
  _WorkShiftFormState createState() => _WorkShiftFormState();
}

class _WorkShiftFormState extends State<WorkShiftForm> {
  final FirestoreService _firestoreService = FirestoreService();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final inputDateController = TextEditingController();
  final inputStartTimeController = TextEditingController();
  final inputEndTimeController = TextEditingController();
  final inputBeginRestTimeController = TextEditingController();
  final inputEndRestTimeController = TextEditingController();

  String place;
  DateTime date;
  TimeOfDay restStart;
  TimeOfDay restEnd;
  TimeOfDay startShifTime;
  TimeOfDay endShiftTime;
  bool isAssigned;
  User selectedUser;
  bool loading = false;
  bool autoValidate = false;
  Future<List<User>> employeesFutureList;
  
  @override
  void initState() {
    employeesFutureList = _firestoreService.getAllEmployees();
    date = DateTime.now();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => loading
          ? InProgressLoader()
          : Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                height: double.maxFinite,
                child: SingleChildScrollView(
                  child: Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        FutureBuilder(
                          future: employeesFutureList,
                          builder: (ctx, AsyncSnapshot<List<User>> snapshot) {
                            return !snapshot.hasData
                                ? CircularProgressIndicator()
                                : FormField(
                                  initialValue: selectedUser,
                                    // onSaved: (val) { print(val); employeeId = val; },
                                    builder: (FormFieldState state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                            icon: const Icon(Icons.person),
                                            hintText: "Välj personal"),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<User>(
                                            isExpanded: true,
                                            isDense: true,
                                            hint: Text("Välj personal"),
                                            onChanged: (User user) {
                                              setState(() {
                                                print(user.email);
                                                selectedUser = user;
                                              });
                                            },
                                            value: selectedUser,
                                            selectedItemBuilder: (ctx) =>
                                                snapshot.data
                                                    .map<Widget>(
                                                      (u) => Row(
                                                        children: <Widget>[
                                                          CircularImage(
                                                            height: 30.0,
                                                            width: 30.0,
                                                            imagePath:
                                                                u.photo,
                                                          ),
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Text(
                                                              "${u.firstname} ${u.lastname}"),
                                                        ],
                                                      ),
                                                    )
                                                    .toList(),
                                            items: snapshot?.data
                                                ?.map(
                                                  (User user) =>
                                                      DropdownMenuItem<User>(
                                                    child: Row(
                                                      children: <Widget>[
                                                        CircularImage(
                                                          imagePath: user.photo,
                                                          width: 40.0,
                                                          height: 40.0,
                                                        ),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                            "${user.firstname} ${user.lastname}")
                                                      ],
                                                    ),
                                                    value: user,
                                                  ),
                                                )
                                                ?.toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          },
                        ),
                        TextFormField(
                          // initialValue: place,
                          decoration: InputDecoration(
                            hintText: "Arbetsplats",
                            icon: Icon(Icons.place),
                          ),
                          onSaved: (value) => place = value,
                          validator: (val) {
                            return val == null || val == "" ? "Ange arbetsplats" : null;
                          },
                        ),
                        TextFormField(
                          onSaved: (val) => date = DateTime.parse(val),
                          validator: (val) {
                            return val == "" ? "Ange datum" : null;
                          },
                          controller: inputDateController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final pickedDate = await showDatePicker(
                              locale: Locale("sv"),
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime(DateTime.now().year - 10, 1, 1),
                              lastDate:
                                  DateTime(DateTime.now().year + 10, 1, 1),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                inputDateController.text =
                                    DateFormat.yMd('sv_SE').format(pickedDate);
                              });
                            }
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              hintText: "Datum"),
                        ),
                        TextFormField(
                          validator: (val) {
                            return val == "" ? "Ange tid" : null;
                          },
                          onSaved: (val) => startShifTime = TimeOfDay(
                              hour: int.parse(val.split(":")[0]),
                              minute: int.parse(val.split(":")[1])),
                          controller: inputStartTimeController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 8, minute: 0),
                                builder: (ctx, child) {
                                  return MediaQuery(
                                    child: child,
                                    data: MediaQuery.of(ctx)
                                        .copyWith(alwaysUse24HourFormat: true),
                                  );
                                });

                            if (pickedTime != null) {
                              setState(() {
                                final time12h = pickedTime.format(context);
                                final time24h = DateFormat("HH:mm").parse(time12h);
                                inputStartTimeController.text =
                                    DateFormat("HH:mm").format(time24h);
                              });
                            }
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.alarm_on), hintText: "Börjar"),
                        ),
                        TextFormField(
                          validator: (val) {
                            return val == "" ? "Ange tid" : null;
                          },
                          onSaved: (val) => endShiftTime = TimeOfDay(
                              hour: int.parse(val.split(":")[0]),
                              minute: int.parse(val.split(":")[1])),
                          controller: inputEndTimeController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 17, minute: 0),
                                builder: (ctx, child) {
                                  return MediaQuery(
                                    child: child,
                                    data: MediaQuery.of(ctx)
                                        .copyWith(alwaysUse24HourFormat: true),
                                  );
                                });

                            if (pickedTime != null) {
                              setState(() {
                                final time12h = pickedTime.format(context);
                                final time24h = DateFormat("HH:mm").parse(time12h);
                                print(time24h);
                                inputEndTimeController.text =
                                    DateFormat("HH:mm").format(time24h);
                              });
                            }
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.alarm_off), hintText: "Slutar"),
                        ),
                        TextFormField(
                          // initialValue: restStart?.format(context),
                          validator: (val) {
                            return val == "" ? "Ange tid" : null;
                          },
                          onSaved: (val) => restStart = TimeOfDay(
                              hour: int.parse(val.split(":")[0]),
                              minute: int.parse(val.split(":")[1])),
                          controller: inputBeginRestTimeController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 17, minute: 0),
                                builder: (ctx, child) {
                                  return MediaQuery(
                                    child: child,
                                    data: MediaQuery.of(ctx)
                                        .copyWith(alwaysUse24HourFormat: true),
                                  );
                                });

                            if (pickedTime != null) {
                              setState(() {
                                final time12h = pickedTime.format(context);
                                final time24h = DateFormat("HH:mm").parse(time12h);
                                inputBeginRestTimeController.text =
                                    DateFormat("HH:mm").format(time24h);
                              });
                            }
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.local_cafe),
                              hintText: "Rast start"),
                        ),
                        TextFormField(
                          // initialValue: restEnd?.toString(),
                          validator: (val) {
                            return val == null || val == "" ? "Ange tid" : null;
                          },
                          onSaved: (val) => restEnd = TimeOfDay(
                              hour: int.parse(val.split(":")[0]),
                              minute: int.parse(val.split(":")[1])),
                          controller: inputEndRestTimeController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 17, minute: 0),
                                builder: (ctx, child) {
                                  return MediaQuery(
                                    child: child,
                                    data: MediaQuery.of(ctx)
                                        .copyWith(alwaysUse24HourFormat: true),
                                  );
                                });

                            if (pickedTime != null) {
                              setState(() {
                                final time12h = pickedTime.format(context);
                                final time24h = DateFormat("HH:mm").parse(time12h);
                                inputEndRestTimeController.text =
                                    DateFormat("HH:mm").format(time24h);
                              });
                            }
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.local_cafe),
                              hintText: "Rast slut"),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () async {
                              if (_key.currentState.validate()) {
                                _key.currentState.save();
                                final workShift = WorkShift(
                                  name: "${selectedUser.firstname} ${selectedUser.lastname}",
                                  date: DateFormat("yyyyMMdd").format(date),
                                  place: place,
                                  startShiftDate: DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      startShifTime.hour,
                                      startShifTime.minute),
                                  endShiftDate: DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      endShiftTime.hour,
                                      endShiftTime.minute),
                                  employeeId: selectedUser.id,
                                  employeePhoto: selectedUser.photo,
                                  isAssigned: selectedUser != null,
                                  period: DateFormat("yyyyMM").format(date),
                                  restStart: DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      restStart.hour,
                                      restStart.minute),
                                  restEnd: DateTime(date.year, date.month,
                                      date.day, restEnd.hour, restEnd.minute),
                                );
                                
                                setState(() {
                                  loading = true;
                                });
                                
                                final bool result = await _firestoreService
                                    .createWorkShift(workShift);

                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: result
                                      ? Colors.green[600]
                                      : Colors.red[900],
                                  content: Container(
                                    child: Row(
                                      children: [
                                        result
                                            ? Text("Arbetspasset har sparats!")
                                            : Text(
                                                "Något gick fel när data skulle sparas."),
                                        Spacer(),
                                        result
                                            ? Icon(Icons.check_circle)
                                            : Icon(Icons.error_outline)
                                      ],
                                    ),
                                  ),
                                ));

                                selectedUser = null;
                                inputDateController.clear();
                                inputEndRestTimeController.clear();
                                inputEndTimeController.clear();
                                inputStartTimeController.clear();
                                inputBeginRestTimeController.clear();
                              }

                              if (!mounted) return;

                              setState(() {
                                loading = false;
                                autoValidate = true;
                              });
                            },
                            child: Text("Spara"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
