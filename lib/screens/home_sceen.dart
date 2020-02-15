import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Row(
            children: <Widget>[
              Text("Januari"),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          onTap: (){},
        ),
        titleSpacing: 0.0,
      ),
      body: Container(),
    );
}
}
