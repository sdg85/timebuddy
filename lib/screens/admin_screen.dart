import 'package:flutter/material.dart';
import 'package:timebuddy/screens/register_user_screen.dart';
import 'package:timebuddy/screens/work_shift_form.dart';
import 'package:timebuddy/widgets/app_drawer.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = "/admin";
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  AdminScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: DefaultTabController(
          length: 2,
          child: WillPopScope(
            onWillPop: () async => false,
                      child: Scaffold(
              key: _drawerKey,
              drawer: AppDrawer(
                title: "Admin",
              ),
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.sort, size: 30.0,),
                  onPressed: () => _drawerKey.currentState.openDrawer(),
                ),
                title: Text("Administartion"),
                centerTitle: true,
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.person_add),
                    ),
                    Tab(
                      icon: Icon(Icons.work),
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                RegisterUserScreen(),
                WorkShiftForm()
              ]),
            ),
          ),
        ),
    );
  }
}
