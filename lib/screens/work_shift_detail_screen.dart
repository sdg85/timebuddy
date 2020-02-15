import 'package:flutter/material.dart';
import 'package:timebuddy/models/work_shift.dart';
import 'package:timebuddy/widgets/layout.dart';

class WorkShiftDetailScreen extends StatelessWidget {
  static const String routeName = "/workshiftdetail";
  final WorkShift workShift;
  const WorkShiftDetailScreen({Key key, this.workShift}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final middle = MediaQuery.of(context).size.width / 2.7;
    return Layout(
      appBarTitleWidget: Text(
        "Work shift details",
        style: TextStyle(fontSize: 15.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.2,
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          Positioned(
            top: 60.0,
            left: middle,
            child: Hero(
              tag: workShift.firstName + workShift.lastName,
              transitionOnUserGestures: true,
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                return SingleChildScrollView(child: toHeroContext.widget);
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xffF2F4F9), width: 5.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.0),
                                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: "assets/images/image-placeholder.png",
                    image: workShift.employeePhoto,
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
