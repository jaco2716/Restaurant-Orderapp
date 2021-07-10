import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/Logic/AuthService.dart';
import 'package:restaurantorderapp/Logic/ValidateValues.dart';
import 'package:restaurantorderapp/MyWidgets/MyAlertDialog.dart';
import 'package:restaurantorderapp/MyWidgets/MyAppBar.dart';
import 'package:restaurantorderapp/MyWidgets/MyLoginWidgets/MyRoundedButton.dart';
import 'package:restaurantorderapp/MyWidgets/MyLoginWidgets/MyTextFieldWidget.dart';

import '../../flavors.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? _fullName = '';
  String? _phoneNr = '';
  String? _password = '';
  String? _email = '';

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthService _authService = AuthService();
  ValidateValues _validateValues = ValidateValues();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar('Sign Up'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(height: 150, child: Image.asset(F.appIconPathDark)),
                  Text('Velkommen!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Lav en ny account.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                MyTextFieldWidget(
                  hintText: 'Fulde navn',
                    icon: Icon(Icons.person),
                  obscureText: false,
                  textInputType: TextInputType.name,
                  validate: (value) => _validateValues.validateString(value),
                  setValue: (value) => _fullName = value,
                ),
                MyTextFieldWidget(
                  hintText: 'Mobil nummer',
                    icon: Icon(Icons.phone),
                  obscureText: false,
                  textInputType: TextInputType.phone,
                  validate: (value) => _validateValues.validateString(value),
                  setValue: (value) => _phoneNr = value,
                ),
                MyTextFieldWidget(
                  hintText: 'E-mail',
                    icon: Icon(Icons.email),
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  validate: (value) => _validateValues.validateEmail(value),
                  setValue: (value) => _email = value,
                ),
                MyTextFieldWidget(
                  hintText: 'Password',
                    icon: Icon(Icons.lock),
                  obscureText: true,
                  textInputType: TextInputType.visiblePassword,
                  validate: (value) => _validateValues.validateString(value),
                  setValue: (value) => _password = value,
                ),
                MyRoundedButton(title: 'Sign up', myOnPressed: () {
                  signUpButtonMethod();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUpButtonMethod() async {
    print('Validating...');
    // Validate will return true if is valid, or false if invalid.
    if (_formKey.currentState!.validate()) {
      print('validate success.');
      _formKey.currentState!.save();
      try {
        await _authService.createUser(
            fullName: _fullName!,
            phoneNr: _phoneNr!,
            email: _email!,
            password: _password!);
        Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        // handle the firebase specific error
        return _buildErrorDialog(context, 'Error Message', error.message as String);
      } on Exception catch (error) {
        // gracefully handle anything else that might happen..
        return _buildErrorDialog(context, 'Error Message', error.toString().split(',')[1]);
      }
    } else {
      print('validate not success.');
      setState(() {});
    }
  }

  Future _buildErrorDialog(BuildContext context, String _title, String _message) {
    return showDialog(
      builder: (context) {
        return MyAlertDialog(
          cancelText: 'Cancel',
          infoDialog: true,
          title: _title,
          content: Text(_message, textAlign: TextAlign.center),
          myOnPressed: () {},
        );
      },
      context: context,
    );
  }
}
