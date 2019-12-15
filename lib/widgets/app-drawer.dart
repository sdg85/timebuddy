import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _selectedTitle;

  final drawerItems = [
    {"title": "Schema", "icon": Icons.calendar_today},
    {"title": "Tid", "icon": Icons.schedule},
    {"title": "Mail", "icon": Icons.mail_outline},
    {"title": "Kollegor", "icon": Icons.people_outline},
    {"title": "Minsida", "icon": Icons.person_outline},
    {"title": "Intresseanmälan", "icon": Icons.today},
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(65)),
        child: SizedBox(
          width: 250,
          child: Drawer(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 30),
                  child: Image.asset("assets/images/logo.png", scale: 3.5),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: drawerItems.length,
                    itemBuilder: (context, index) {
                      final item = drawerItems[index];
                      return _listTileBuilder(
                          title: item["title"],
                          icon: item["icon"],
                          selected: item["title"] == _selectedTitle);
                    },
                  ),
                ),
                Align(
                  child: Image.asset(
                    "assets/images/menu_bg.png",
                    scale: 2.5,
                  ),
                  alignment: Alignment.bottomRight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //custom list tile for drawer
  Container _listTileBuilder(
      {@required String title, IconData icon, bool selected = false}) {
    return Container(
      margin: EdgeInsets.only(left: 1.0),
      decoration: BoxDecoration(
          color: selected ? Color(0xffF2F8FC) : Colors.white,
          border: selected
              ? Border(
                  left: BorderSide(color: Color(0xff017ACD), width: 4.0),
                )
              : Border(left: BorderSide.none)),
      child: ListTile(
        dense: true,
        onTap: () {
          setState(() {
            _selectedTitle = title;
          });
        },
        title: Text(title,
            style: TextStyle(
                color: selected ? Color(0xff017ACD) : Color(0xff7A7C81),
                fontSize: 14.0,
                fontWeight: FontWeight.w500)),
        leading: Icon(
          icon,
          color: selected ? Color(0xff017ACD) : Color(0xff7A7C81),
          size: 25,
        ),
      ),
    );
  }
}
