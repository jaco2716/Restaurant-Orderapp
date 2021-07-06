

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/model/MenuItem.dart';
import 'Login/AuthService.dart';
import 'package:provider/provider.dart';

import 'Login/LoginPage.dart';
import 'MyWidgets/LoadingCircle.dart';
import 'pages/OrderPageContent/ConfirmDetailsPage.dart';
import 'pages/ReceiptPageContent/ReceiptListPage.dart';
import 'pages/my_home_page.dart';

Widget loginNextPage(List<MenuItem> cartItems, String nextPage) {

  return ChangeNotifierProvider<AuthService>(
    child: OrderPageProvider(cartItems, nextPage),
    create: (BuildContext context) {
      return AuthService();
    },
  );
}

class OrderPageProvider extends StatelessWidget {
  final List<MenuItem> cartItems;
  final String nextPage;
  //final List<MenuItem> cartItems = List<MenuItem>();
  OrderPageProvider(this.cartItems, this.nextPage);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // log error to console
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }
            // redirect to the proper page, pass the user into the
            // `HomePage` so we can display the user email in welcome msg
            //print("SnapshotData: " + snapshot.data.email);
            if (!snapshot.hasData)
              return LoginPage();
            else if (nextPage == "OrderPage")
              return ConfirmDetailsPage(cartItems, snapshot.data);
            else if (nextPage == "ReceiptPage")
              return ReceiptListPage(snapshot.data);
            else if (nextPage == "SettingsPage")
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route<dynamic> route) => false);
              });
            // Navigator.of(context).pop();

            return Center();

            //return SettingsPage();
          } else {
            // show loading indicator
            return LoadingCircle();
          }
        });
  }
}
