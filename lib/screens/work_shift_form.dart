import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timebuddy/models/user.dart';
import 'package:timebuddy/services/firestore_service.dart';
import 'package:timebuddy/widgets/in_progress_loader.dart';

class WorkShiftForm extends StatefulWidget {
  WorkShiftForm({Key key}) : super(key: key);

  @override
  _WorkShiftFormState createState() => _WorkShiftFormState();
}

class _WorkShiftFormState extends State<WorkShiftForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String name;
  String employeeId;
  String date;
  String period;
  String photoUrl;
  String place;
  DateTime restStart;
  DateTime restEnd;
  DateTime startShiftDate;
  DateTime endShiftDate;
  bool isAssigned;
  bool _loading = false;

final FirestoreService _firestoreService = FirestoreService();

@override
  void initState() {
    super.initState();
  }     

  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => _loading
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
                            future: _firestoreService.getAllEmployees(),
                            builder: (ctx, AsyncSnapshot<List<User>> snapshot) {
                              return DropdownButton(
                                onChanged: (value) {
                                  print(value);
                                },
                                items: snapshot?.data
                                    ?.map(
                                      (User user) => DropdownMenuItem(
                                        child: Text(
                                            "${user.firstname} ${user.lastname}"),
                                        value: user.id,
                                      ),
                                    )
                                    ?.toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
    );
  }
}
