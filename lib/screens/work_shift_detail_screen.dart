import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timebuddy/models/work_shift.dart';

class WorkShiftDetailScreen extends StatelessWidget {
  static const String routeName = "/workshiftdetail";
  final WorkShift workShift;
  const WorkShiftDetailScreen({Key key, this.workShift}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final middle = MediaQuery.of(context).size.width / 2.7;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back),
            onPressed: (){ Navigator.of(context).pop(); },
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            DateFormat("yyyy-MM-dd").format(workShift.startShiftDate),),
            centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.08,
              child: Container(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Positioned(
              top: 0.0,
              left: middle,
              child: Hero(
                tag: workShift.name,
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
      ),
    );
  }
}
