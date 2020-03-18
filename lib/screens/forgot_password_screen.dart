import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:timebuddy/services/auth_service.dart';
import 'package:timebuddy/widgets/in_progress_loader.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email;
  // TextEditingController _controller;
  bool _loading = false;
  AuthService auth = AuthService();
  String _errorMessage;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF2F4F9),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _loading
              ? InProgressLoader()
              : Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Återställ ditt lösenord",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Divider(
                      //   color: Colors.grey,
                      // ),

                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(height: 1.0),
                        decoration: InputDecoration(
                          hintText: "E-postadress",
                          hintStyle: TextStyle(fontWeight: FontWeight.w500),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.email),
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
                        initialValue: _email,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Ange den e-postadress som du använde när du registrerade dig."
                        "Vi skickar ett e-postmeddelande med en länk där du kan återställa ditt lösenord.",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          textColor: Colors.white,
                          child: Text("Skicka verfikations mail"),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() => _loading = true);
                              _formKey.currentState.save();
                              final result = await auth.forgotPassword(_email);

                              if (result)
                                Navigator.pop(context);
                              else
                                setState(() {
                                  _errorMessage =
                                      "Kunde inte hitta användare med detta e-postadress";
                                  _loading = false;
                                });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      _errorMessage != null
                          ? Text(
                              _errorMessage,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          : Text(""),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
