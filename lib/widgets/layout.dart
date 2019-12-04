import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timebuddy/services/auth_service.dart';

class Layout extends StatelessWidget {
  final String title;
  final Widget child;
  final AuthService auth = AuthService();
  final GlobalKey<ScaffoldState> _layoutKey = GlobalKey<ScaffoldState>();

  Layout({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _layoutKey,
        backgroundColor: Color(0xff017ACD),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.sort,
                size: 30,
              ),
              onPressed: () {
                _layoutKey.currentState.openDrawer();
              },
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xff017ACD),
            title: Text(title),
          ),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                    Duration(milliseconds: 400),
                    () async => await auth.signOut(),
                  );
                },
              )
            ],
          ),
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(60),
          ),
          child: Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            constraints: BoxConstraints.expand(),
            color: Color(0xffF2F4F9),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
