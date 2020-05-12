import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/models/user_location.dart';
import 'package:timebuddy/widgets/layout.dart';

class StampScreen extends StatefulWidget {
  static const String routeName = "/stamp";

  const StampScreen({Key key}) : super(key: key);

  @override
  _StampScreenState createState() => _StampScreenState();
}

class _StampScreenState extends State<StampScreen> {
  int hours = 00;
  int minutes = 00;
  bool isActive = false;
  double size = 54.0;
  Timer timer;
  String local = "";

  void handleTick() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (!mounted) return;
        minutes++;
        if (minutes > 10) {
          minutes = 00;
          hours++;
        }
      });
    });
  }

  @override
  void dispose() {
    if(timer != null)
      timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Consumer<UserLocation>(
        builder: (ctx, location, _) => SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 300.0,
                  width: 90.0,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                    radius: 1.4,
                    colors: [Colors.blue[100], Color(0xffF2F4F9)],
                  )),
                  child: Text(
                    hours.toString().padLeft(2, "0"),
                    style:
                        TextStyle(fontSize: size, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    ":",
                    style:
                        TextStyle(fontSize: size, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 300.0,
                  width: 90.0,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [Colors.blue[100], Color(0xffF2F4F9)],
                      radius: 1.4,
                    ),
                  ),
                  child: Text(
                    minutes.toString().padLeft(2, '0'),
                    style:
                        TextStyle(fontSize: size, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Text(
              "You can punch in when you are",
              style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
            ),
            Text(
              "close to work",
              style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 330.0,
              height: 60.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.only(right: 3.0, left: 3.0),
                color: Colors.blue,
                child: Text(
                  "Punch In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
                onPressed:
                    location?.street?.toLowerCase() != local.toLowerCase()
                        ? null
                        : () {
                            handleTick();
                          },
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              location == null
                  ? "Can't acces your location"
                  : "${location.city}, ${location.street}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Address",
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder()),
                onSubmitted: (value) {
                  setState(() {
                    local = value;
                  });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
