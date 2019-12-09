import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebuddy/screens/forgot_password_screen.dart';
import 'package:timebuddy/services/auth_service.dart';
import 'package:timebuddy/widgets/in_progress_loader.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  String _errorMessage;
  bool _loading = false;
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return SafeArea(
      child: _loading
          ? InProgressLoader()
          : Scaffold(
              resizeToAvoidBottomPadding: false,
              backgroundColor: Color(0xff017ACD),
              body: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(60)),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 90,
                    color: Color(0xffF2F4F9),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Form(
                        autovalidate: _autoValidate,
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset("assets/images/logo.png", scale: 3.5),
                            SizedBox(
                              height: 50.0,
                            ),
                            Text(
                              "Logga in",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              initialValue: _email,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(height: 1.0),
                              decoration: InputDecoration(
                                hintText: "Användarnamn",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500
                                  ),
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Image.asset(
                                  "assets/images/user.png",
                                  scale: 2.0,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              validator: (value) {
                                if (!EmailValidator.validate(value)) {
                                  return "Var god och ange ett giltigt e-postadress";
                                }
                                return null;
                              },
                              onSaved: (value) => _email = value,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: _password,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                height: 1.0,
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Lösenord",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w500),
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Image.asset(
                                  "assets/images/password.png",
                                  scale: 2.0,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Ange ett lösenord";
                                }
                                if (value.length < 6) {
                                  return "Lösenorder måste innehålla minst 6 tecken";
                                }

                                return null;
                              },
                              onSaved: (value) => _password = value,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Colors.blue[700],
                              padding: EdgeInsets.only(right: 0, left: 30),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  setState(() => _loading = true);
                                  final result =
                                      await auth.signInWithEmailAndPassword(
                                          _email, _password);

                                  if (result == null) {
                                    setState(() {
                                      _loading = false;
                                      _errorMessage =
                                          "Något gick fel vid inloggningen var vänlig försök igen";
                                    });
                                  }
                                }
                                setState(() {
                                  _autoValidate = true;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Logga in",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    width: 70,
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      color: Colors.blue[800],
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Glömt lösenord?",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              child: _errorMessage == null
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Har du inget konto?",
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            "Registrera",
                                            style: TextStyle(
                                                color: Color(0xff017ACD),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    )
                                  : Center(
                                      child: Text(
                                        _errorMessage,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
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
