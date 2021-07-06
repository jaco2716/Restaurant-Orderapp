import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantorderapp/MyWidgets/LoadingCircle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AuthService.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  String _snackError = '';
  final _forgotEmailFormKey = GlobalKey<FormState>();
  String _forgotEmail = '';
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //appBar: AppBarLeo('Login'),
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 50, right: 50, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green[200]),
                      ),
                    ),
                  ),
                  InputField(
                    TextFormField(
                      onSaved: (value) => _email = value as String,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "E-mail",
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  InputField(
                    TextFormField(
                      onSaved: (value) => _password = value as String,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  FlatButton(
                    textColor: Colors.red,
                    child: Text("Glemt Password?"),
                    onPressed: () async {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                      // _snackError = 'Password Reset Canceled.';
                      await _buildForgotPassDialog();

                      // showNewSnackBar(_snackError);
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      textColor: Colors.white,
                      child: Text("Login"),
                      onPressed: () {
                        showDialog(context: context, builder: (context) => LoadingCircle());
                        loginButtonMethod(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FlatButton(
                    child: Text("Opret en ny account her."),
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())).then((value) => setState(() {}));
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FlatButton(
                      textColor: Colors.blue[300],
                      onPressed: () async {
                        await launch('https://www.termsfeed.com/live/788db393-f183-46a5-8762-315633123cd8');
                      },
                      child: Text('Privacy Policy')),
                ],
              ),
            ),
          ),
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
        User? result = await Provider.of<AuthService>(context, listen: false).loginUser(email: _email, password: _password);
        print(result);
      } on FirebaseAuthException catch (error) {
        // handle the firebase specific error
        return _buildErrorDialog(context, 'Error Message', error.message as String);
      } on Exception catch (error) {
        // gracefully handle anything else that might happen..
        print(error.toString());
        return _buildErrorDialog(context, 'Error Message', "Something went wrong. Please try again");
      }
    }
  }

  forgotPasswordMehtod(BuildContext dialogContext) async {
    final forgotForm = _forgotEmailFormKey.currentState!;
    forgotForm.save();
    Navigator.pop(dialogContext);

    if (forgotForm.validate()) {
      print('success validate');
      try {
        //await auth.sendForgotPasswordEmail(_forgotEmail);
        await _authService.sendForgotPasswordEmail(_forgotEmail);
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
        return Dialog(
          backgroundColor: Colors.teal[700],
          insetPadding: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _forgotEmailFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Glemt Password',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  InputField(
                    TextFormField(
                      onSaved: (value) => _forgotEmail = value as String,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "E-mail",
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    elevation: 20,
                    color: Colors.teal[400],
                    textColor: Colors.white,
                    child: Text("Nulstil Password"),
                    onPressed: () {
                      // forgotPasswordMehtod(dialogContext);
                      //Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      context: context,
    );
  }

  Future _buildErrorDialog(BuildContext context, String _title, String _message) {
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

class InputField extends StatelessWidget {
  final TextFormField _textFormField;
  InputField(this._textFormField);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(5)),
        child: _textFormField);
  }
}
