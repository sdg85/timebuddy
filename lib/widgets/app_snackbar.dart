import 'package:flutter/material.dart';

class AppSnackbar extends StatelessWidget {
  final bool valid = false;
  const AppSnackbar({Key key, valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: valid ? Colors.green[600] : Colors.red[900],
      content: Container(
        child: Row(
          children: [
            valid
                ? Text("User successfully created")
                : Text("Något gick fel när användaren skulle sparas."),
            Spacer(),
            valid ? Icon(Icons.check_circle) : Icon(Icons.error_outline)
          ],
        ),
      ),
    );
  }
}
