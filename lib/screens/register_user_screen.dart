import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:timebuddy/widgets/layout.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../widgets/in_progress_loader.dart';

class RegisterUserScreen extends StatefulWidget {
  static const String routeName = "/registeruser";
  RegisterUserScreen({Key key}) : super(key: key);

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  AuthService auth = AuthService();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String firstName;
  String lastName;
  String email;
  String photo;
  String password;
  bool loading = false;
  bool autoValidate = false;
  bool valid = false;

  SnackBar createSnackBar({@required bool valid}) {
    return SnackBar(
        backgroundColor: valid ? Colors.green[600] : Colors.red[900],
        content: Container(
          child: Row(
            children: [
              valid
                  ? Text("User successfully created")
                  : Text(
                      "Något gick fel vid inloggningen var vänlig försök igen"),
                      Spacer(),
              valid ? Icon(Icons.check_circle) : Icon(Icons.error_outline)
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      title: "Admin",
      appBarTitleWidget: Text("Registrera"),
      child: Builder(
        builder: (ctx) => loading
            ? InProgressLoader()
            : Padding(
                padding: EdgeInsets.all(30.0),
                child: Container(
                  child: Container(
                    height: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _key,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onSaved: (val) => firstName = val,
                              decoration: InputDecoration(labelText: "Förnamn"),
                              validator: (val) {
                                return val == ""
                                    ? "Förnamn är obligatoriskt."
                                    : null;
                              },
                            ),
                            TextFormField(
                              onSaved: (val) => lastName = val,
                              decoration:
                                  InputDecoration(labelText: "Efternamn"),
                              validator: (val) {
                                return val == ""
                                    ? "Efternamn är obligatoriskt."
                                    : null;
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (val) => email = val,
                              decoration: InputDecoration(labelText: "E-post"),
                              validator: (value) {
                                if (!EmailValidator.validate(value)) {
                                  return "Var god och ange ett giltigt e-postadress";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Ange ett lösenord";
                                }
                                if (value.length < 6) {
                                  return "Lösenorder måste innehålla minst 6 tecken";
                                }

                                return null;
                              },
                              onSaved: (val) => password = val,
                              decoration:
                                  InputDecoration(labelText: "Lösenord"),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: double.maxFinite - 30.0,
                              child: RaisedButton(
                                child: Text(
                                  "Registrera",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () async {
                                  if (_key.currentState.validate()) {
                                    _key.currentState.save();
                                    setState(() => loading = true);
                                    var user = User(
                                        email: email,
                                        firstname: firstName,
                                        lastname: lastName,
                                        photo: photo);
                                    final result =
                                        await auth.newUser(password, user);

                                    loading = false;
                                    final snackBar =
                                        createSnackBar(valid: result);
                                    Scaffold.of(ctx).showSnackBar(snackBar);
                                  }
                                  if (!mounted) return;
                                  setState(() {
                                    autoValidate = true;
                                  });
                                },
                                color: Color(0xff017ACD),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
