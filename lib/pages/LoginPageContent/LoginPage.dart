import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:restaurantorderapp/Logic/AuthService.dart';
import 'package:restaurantorderapp/Logic/ValidateValues.dart';
import 'package:restaurantorderapp/MyWidgets/LoadingCircle.dart';
import 'package:restaurantorderapp/MyWidgets/MyAlertDialog.dart';
import 'package:restaurantorderapp/MyWidgets/MyAppBar.dart';
import 'package:restaurantorderapp/MyWidgets/MyLoginWidgets/MyTextFieldWidget.dart';
import 'package:restaurantorderapp/flavors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _password = '';
  String? _email = '';
  String? _forgotEmail = '';
  final _forgotEmailFormKey = GlobalKey<FormState>();
  String _snackError = '';
  AuthService _authService = AuthService();
  ValidateValues _validateValues = ValidateValues();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('Sign in'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 150,
                    width: double.infinity,
                    child: Image.asset(F.appIconPathDark),
                  ),
                  Text('Velkommen!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign in med din account.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  MyTextFieldWidget(
                    hintText: 'E-mail',
                    icon: Icon(Icons.email),
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                    validate: (value) => _validateValues.validateString(value),
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
                  Container(
                    height: 40,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            _buildForgotPassDialog();
                          },
                          child: Text('Glemt password? ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 7),
                    width: double.infinity,
                    height: 73,
                    child: ElevatedButton(
                      onPressed: () {
                        // showDialog(context: context, builder: (context) => LoadingCircle());
                        loginButtonMethod(context);
                      },
                      child: Text('SIGN IN'),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          text: 'Ingen account? ',
                          children: [
                        TextSpan(
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          text: 'Sign up\n',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage())).then((value) => setState(() {}));
                            },
                        )
                      ]))
                ],
              )),
        ),
      ),
    );
  }

  void showNewSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    ));
  }

  loginButtonMethod(BuildContext context) async {
    final form = _formKey.currentState!;
    form.save();

    // Validate will return true if is valid, or false if invalid.
    if (form.validate()) {
      try {
        User? result = await _authService.loginUser(email: _email!, password: _password!);
        print('Success: $result');
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (error) {
        // handle the firebase specific error
        return _buildErrorDialog(context, 'Error Message', error.message as String);
      } on Exception catch (error) {
        // gracefully handle anything else that might happen..
        print('Exception caught: ${error.toString()}');
        return _buildErrorDialog(context, 'Error Message', "Something went wrong. Please try again");
      }
    }
  }

  forgotPasswordMehtod(BuildContext dialogContext) async {
    final forgotForm = _forgotEmailFormKey.currentState!;
    forgotForm.save();

    if (forgotForm.validate()) {
      Navigator.pop(dialogContext);
      print('success validate');
      try {
        await _authService.sendForgotPasswordEmail(_forgotEmail!);
        print('success reset');
        _snackError = 'En email er blevet sendt med nulstilling';
        return showNewSnackBar(_snackError);
        //print(result);
      } on FirebaseAuthException catch (error) {
        // handle the firebase specific error
        print('AuthExeption: ' + error.toString());

        _snackError = 'Error - ' + error.toString().split(',')[1];
        return showNewSnackBar(_snackError);
      } catch (error) {
        // gracefully handle anything else that might happen..
        print('Other Exeption: ' + error.toString());

        _snackError = 'Error: ' + error.toString().split(',')[1];
        return showNewSnackBar(_snackError);
      }
    }
  }

  Future _buildForgotPassDialog() {
    return showDialog(
      builder: (dialogContext) {
        return MyAlertDialog(
            title: 'Glemt Password',
            content: Form(
              key: _forgotEmailFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Indtast din e-mail og vi sender dig et link til at reset dit password.\n', textAlign: TextAlign.center),
                  MyTextFieldWidget(
                    hintText: 'E-mail',
                    icon: Icon(Icons.email),
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                    validate: (value) => _validateValues.validateString(value),
                    setValue: (value) => _forgotEmail = value,
                    horizontalPaddig: 0,
                  ),
                ],
              ),
            ),
            confirmText: 'Reset',
            cancelText: 'Cancel',
            myOnPressed: () {
              forgotPasswordMehtod(dialogContext);
              // Navigator.pop(context);
            });
      },
      context: context,
    );
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
