import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

class StampScreen extends StatefulWidget {
  static const String routeName = "/stamp";

  const StampScreen({Key key}) : super(key: key);

  @override
  _StampScreenState createState() => _StampScreenState();
}

class _StampScreenState extends State<StampScreen> {
  int hours = 0;
  int minutes = 0;
  bool isActive = false;
  Timer _timer;

  void startTimer() {
    if (!isActive) {
      isActive = true;
      Timer.periodic(Duration(seconds: 1), (timer) {
        _timer = timer;
        setState(() {
          minutes++;
          if (minutes > 10) {
            hours++;
            minutes = 0;
          }
        });
      });
    }
  }

  void stopTimer() {
    if (_timer != null && isActive) {
      _timer.cancel();
      isActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "Tid",
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')}",
            style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w500),
          ),
          Text(""),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            color: Colors.green,
            child: Text("Start"),
            onPressed: () => startTimer(),
          ),
          RaisedButton(
            color: Colors.red,
            child: Text("Stop"),
            onPressed: () => stopTimer(),
          )
        ]),
      ),
    );
  }
}
