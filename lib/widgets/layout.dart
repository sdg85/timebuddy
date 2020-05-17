import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/providers/work_shift_provider.dart';
import 'package:timebuddy/routes/routes.dart';
import 'package:timebuddy/screens/schedule_screen.dart';
import 'package:timebuddy/services/auth_service.dart';
import 'package:timebuddy/widgets/app_drawer.dart';
import 'package:timebuddy/widgets/in_progress_loader.dart';

class Layout extends StatefulWidget {
  final String title;
  final Widget appBarTitleWidget;
  final Widget child;

  Layout({Key key, this.title, this.appBarTitleWidget, this.child})
      : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool loading = false;

  final GlobalKey<ScaffoldState> _layoutKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context);
    return SafeArea(
      child: loading
          ? InProgressLoader()
          : WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                key: _layoutKey,
                backgroundColor: Color(0xff017ACD),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(70),
                  child: AppBar(
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.sort,
                        size: 30,
                      ),
                      onPressed: () {
                        _layoutKey.currentState.openDrawer();
                      },
                    ),
                    elevation: 0,
                    backgroundColor: Color(0xff017ACD),
                    title: widget.appBarTitleWidget,
                    actions: <Widget>[
                      PopupMenuButton(
                        onSelected: (value) async {
                          switch (value) {
                            case 1:
                              await _authService.signOut();
                              if(widget.child is! ScheduleScreen){
                                //clear calendar
                                Provider.of<WorkShiftProvider>(context)
                                .selectedDay = null;

                                Navigator.pushReplacementNamed(context, Routes.home);
                              }
                                
                          }
                        },
                        offset: Offset(0, 100),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.exit_to_app,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("Logga ut")
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                drawer: AppDrawer(
                  title: widget.title,
                ),
                body: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                  child: Container(
                    height: double.maxFinite,
                    color: Color(0xffF2F4F9),
                    child: widget.child,
                  ),
                ),
              ),
            ),
    );
  }
}
