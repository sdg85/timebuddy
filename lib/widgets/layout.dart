import 'package:flutter/material.dart';
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
    return SafeArea(
      child: loading
          ? InProgressLoader()
          : Scaffold(
              key: _layoutKey,
              backgroundColor: Color(0xff017ACD),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: AppBar(
                  titleSpacing: MediaQuery.of(context).size.width - 300,
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
                  color: Color(0xffF2F4F9),
                  child: widget.child,
                ),
              ),
            ),
    );
  }
}
