import 'package:flutter/material.dart';
import 'package:restaurantorderapp/model/NextPageEnum.dart';
import '../model/MenuItem.dart';
import '../flavors.dart';
import '/MyWidgets/MyAppBar.dart';
import '../MyWidgets/MyAlertDialog.dart';
import '../Pages/CartPageContent/CartPage.dart';
import '../Pages/MenuPageContent/MenuPage.dart';
import '../Pages/SettingsPageContent/SettingsPage.dart';
import 'LoginPageContent/CheckLoginPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MenuItem> dummyList = [];
  int pageIndex = 0;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initDate();
    });
  }

  initDate() async {
    try {
      // currentDate = await NTP.now();
      bool isOpen = false;
      // isOpen = await CalculateValues.checkIfWithinOpenHours(currentDate);
      if (!isOpen) {
        _buildDialog(context, 'Restauranten er lukket', 'Se åbningstider på info siden.');
      }
    } catch (error) {
      print('date/firestore Error: $error');
    }
  }

  Future _buildDialog(BuildContext context, String _title, String _message) {
    return showDialog(
      builder: (context) {
        return MyAlertDialog(
          title: _title,
          content: Text(_message, textAlign: TextAlign.center),
          cancelText: 'Ok',
          infoDialog: true,
          myOnPressed: () {},
        );
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pageTabs = [
      MenuPage(notifyParent: _refresh),
      CartPage(
        notifyParent: _refresh,
      ),
      CheckLoginPage(NextPage.RecieptPage, 'Sing in for at se dine ordrer.', []),
      // ReceiptListPage(userinfo),
      // SettingsPage(),
      SettingsPage(),
    ];

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: F.appPrimaryColor[900],
          unselectedItemColor: Colors.grey,
          currentIndex: pageIndex,
          items: [
            BottomNavigationBarItem(label: 'Menu', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Kurv', icon: Icon(Icons.shopping_basket)),
            BottomNavigationBarItem(label: 'Ordrer', icon: Icon(Icons.receipt)),
            BottomNavigationBarItem(label: 'Info', icon: Icon(Icons.info))
          ],
          onTap: (index) async {
            setState(() {
              pageIndex = index;
            });
          },
        ),
        appBar: MyAppBar(F.appTitle),
        body: pageTabs[pageIndex]);
  }

  _refresh(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
