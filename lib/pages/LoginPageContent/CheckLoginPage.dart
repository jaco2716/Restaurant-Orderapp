import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/MyWidgets/MyLoginWidgets/MyRoundedButton.dart';
import 'package:restaurantorderapp/model/MenuItem.dart';
import 'package:restaurantorderapp/model/NextPageEnum.dart';
import 'package:restaurantorderapp/pages/LoginPageContent/LoginPage.dart';
import 'package:restaurantorderapp/pages/LoginPageContent/SignUpPage.dart';
import 'package:restaurantorderapp/pages/OrderPageContent/ConfirmDetailsPage.dart';
import 'package:restaurantorderapp/pages/ReceiptPageContent/ReceiptListPage.dart';

import '../../flavors.dart';

// Widget loginNextPage(Widget nextPage, String title) {
//   return ChangeNotifierProvider<AuthService>(
//     create: (_) => AuthService(),
//     child: CheckLoginPage(nextPage, title),

//     // child: CheckLoginPage(nextPage, title),
//   );
// }

class CheckLoginPage extends StatefulWidget {
  final NextPage nextPage;
  final String title;
  final List<MenuItem> cartItems;
  CheckLoginPage(this.nextPage, this.title, this.cartItems);

  @override
  _CheckLoginPageState createState() => _CheckLoginPageState();
}

class _CheckLoginPageState extends State<CheckLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? myUser;
  @override
  void initState() {
    myUser = _auth.currentUser;
    // _auth.authStateChanges().listen((User? user) => setState(() => myUser = user));
    _auth.authStateChanges().listen((User? user) => mounted ? setState(() => myUser = user) : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (myUser == null) {
      return Container(
        width: double.infinity,
        child: SingleChildScrollView(
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
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 40),
              MyRoundedButton(
                  title: 'SIGN IN',
                  myOnPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }),
              MyRoundedButton(
                  title: 'SIGN UP',
                  myOnPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  }),
            ],
          ),
        ),
      );
    } else {
      // return LoginPage();
      if (widget.nextPage == NextPage.OrderPage)
        return ConfirmDetailsPage(widget.cartItems, myUser!);
      else if (widget.nextPage == NextPage.RecieptPage)
        return ReceiptListPage(myUser!);
      else if (widget.nextPage == NextPage.SettingsPage)
        Future.delayed(Duration.zero, () {
          Navigator.popUntil(
            context,
            ModalRoute.withName(
              Navigator.defaultRouteName,
            ),
          );
        });
      return Center();
    }
    // return FutureBuilder<dynamic>(
    //     future: Provider.of<AuthService>(context).getUser(),
    //     builder: (context, AsyncSnapshot<dynamic> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         // log error to console
    //         if (snapshot.error != null) {
    //           print("error");
    //           return Text(snapshot.error.toString());
    //         }
    //         // redirect to the proper page, pass the user into the
    //         // `HomePage` so we can display the user email in welcome msg
    //         //print("SnapshotData: " + snapshot.data.email);
    //         if (!snapshot.hasData)
    //           return Container(
    //             width: double.infinity,
    //             child: Column(
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.all(5),
    //                   height: 150,
    //                   width: double.infinity,
    //                   child: Image.asset(F.appIconPathDark),
    //                 ),
    //                 Text('Velkommen!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Text(
    //                     title,
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(color: Colors.grey),
    //                   ),
    //                 ),
    //                 SizedBox(height: 40),
    //                 MyRoundedButton(
    //                     title: 'SIGN IN',
    //                     myOnPressed: () {
    //                       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    //                     }),
    //                 MyRoundedButton(
    //                     title: 'SIGN UP',
    //                     myOnPressed: () {
    //                       Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
    //                     }),
    //               ],
    //             ),
    //           );
    //         //   return LoginPage();
    //         // else if (nextPage == "OrderPage")
    //         //   return ConfirmDetailsPage(cartItems, snapshot.data);
    //         // else if (nextPage == "ReceiptPage")
    //         //   return ReceiptListPage(snapshot.data);
    //         // else if (nextPage == "SettingsPage")
    //         //   Future.delayed(Duration.zero, () {
    //         //     Navigator.of(context).pushAndRemoveUntil(
    //         //         MaterialPageRoute(builder: (context) => MyHomePage()),
    //         //         (Route<dynamic> route) => false);
    //         //   });
    //         // Navigator.of(context).pop();

    //         return Center();

    //         //return SettingsPage();
    //       } else {
    //         // show loading indicator
    //         return LoadingCircle();
    //       }
    //     });
  }
}
