import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/MyWidgets/MyAppBar.dart';
import 'AuthService.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _phoneNr = '';
  String _password = '';
  String _email = '';
  double _sizedBoxHight = 15;

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar('Sign Up'),
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            //TODO Autovalidate on user interaction?
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        decoration: formFiedDecoration('Fulde Navn'),
                        validator: (value) => validateString(value as String),
                        onSaved: (value) => _fullName = value as String,
                        onFieldSubmitted: (value) => changeFocus(),
                      ),
                      SizedBox(height: _sizedBoxHight),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: formFiedDecoration('Mobil Nummer'),
                        validator: (value) => validateString(value as String),
                        onSaved: (value) => _phoneNr = value as String,
                        onFieldSubmitted: (value) => changeFocus(),
                      ),
                      SizedBox(height: _sizedBoxHight),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: formFiedDecoration('E-mail'),
                        validator: (value) => validateEmail(value as String),
                        onSaved: (value) => _email = value as String,
                        onFieldSubmitted: (value) => changeFocus(),
                      ),
                      SizedBox(height: _sizedBoxHight),
                      TextFormField(
                        obscureText: true,
                        decoration: formFiedDecoration('Password'),
                        validator: (value) => validatePassword(value as String),
                        onSaved: (value) => _password = value as String,
                      ),
                      SizedBox(height: _sizedBoxHight),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                            textColor: Colors.white,
                            child: Text("Sign Up"),
                            onPressed: () {
                              signUpButtonMethod();
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeFocus() {
    FocusScope.of(context).nextFocus();
  }

  InputDecoration formFiedDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  String? validateString(String value) {
    return value.isEmpty ? 'Required' : null;
  }

  String? validatePassword(String value) {
    return value.length < 6 ? 'Password must be at least 6 characters' : null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? 'Invalid E-mail.' : null;
  }

  void signUpButtonMethod() async {
    print('Validating...');
    // Validate will return true if is valid, or false if invalid.
    if (_formKey.currentState!.validate()) {
      print('validate success.');
      _formKey.currentState!.save();
      try {
        await _authService.createUser(
            fullName: _fullName,
            phoneNr: _phoneNr,
            email: _email,
            password: _password);
        Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        // handle the firebase specific error
        return _buildErrorDialog(context, 'Error Message', error.message as String);
      } on Exception catch (error) {
        // gracefully handle anything else that might happen..
        return _buildErrorDialog(
            context, 'Error Message', error.toString().split(',')[1]);
      }
    } else {
      print('validate not success.');
      setState(() {
      });
    }
  }

  Future _buildErrorDialog(
      BuildContext context, String _title, String _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
