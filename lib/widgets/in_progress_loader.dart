import 'package:flutter/material.dart';

class InProgressLoader extends StatelessWidget {
  const InProgressLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color(0xffF2F4F9),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
