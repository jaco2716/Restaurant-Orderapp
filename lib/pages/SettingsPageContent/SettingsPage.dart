// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../../Login/LoadingCircle.dart';
// import '../../LoginPageProvider.dart';
import '../../Model/ApplicationData.dart';
import '../../Model/MenuItem.dart';
// import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:url_launcher/url_launcher.dart'  as urlLauncher;

import '../../flavors.dart';

// import '../Login/AuthService.dart';

// Widget loginNextPage(List<MenuItem> cartItems, String nextPage) {
//   return ChangeNotifierProvider<AuthService>(
//     child: OrderPageProvider(cartItems, nextPage),
//     create: (BuildContext context) {
//       return AuthService();
//     },
//   );
// }

class SettingsPage extends StatefulWidget {
  //final FirebaseUser currentUser;
  //SettingsPage(this.currentUser);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // AuthService _auth = AuthService();

  // Firestore _firestore = Firestore.instance;
  
  @override
  Widget build(BuildContext context) {
    List<dynamic> closingH = [
      21.001,
      21.001,
      21.001,
      21.001,
      21.001,
      21.001,
      21.001,
    ];
    List<dynamic> openH = [
      11.001,
      11.001,
      11.001,
      11.001,
      11.001,
      11.001,
      12.001,
    ];
    ApplicationData appData = ApplicationData(
      versionId: 1,
      deviceToken: '232323',
      closingHours: closingH,
      openingHours: openH,
    );
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 90.0, right: 90, top: 10),
            child: Image.asset(F.appIconPathDark),
          ),
          TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () async {
                dynamic res = await urlLauncher.launch(F.companyWebsite);
                print('call: ' + res.toString());
              },
              child: Text(F.companyWebsite)),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton.icon(
                icon: Icon(Icons.phone),
                onPressed: () async {
                  String _url = 'tel:${F.companyPhone.replaceAll(' ', '')}';

                  dynamic res = await urlLauncher.launch(_url);
                  print('call: ' + res.toString());
                },
                label: Text(F.companyPhone)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              F.companyAddress,
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),

              // textColor: Colors.blue[300],
              onPressed: () async {
                await urlLauncher.launch(
                    F.privacyPolicyURL);
              },
              child: Text('Privacy Policy')),
          // FutureBuilder(
          //   future: _auth.getUser(),
          //   builder:
          //       (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       // log error to console
          //       if (snapshot.error != null) {
          //         print("error");
          //         return Text(snapshot.error.toString());
          //       }
          //       if (snapshot.hasData) {
          //         return settingsButton(
          //             Icon(Icons.lock), "Logout", _buildLogOutDialog);
          //       } else {
          //         return settingsButton(
          //             Icon(Icons.lock_open), "Login", goToPage);
          //       }
          //     } else {
          //       // show loading indicator
          //       return Padding(
          //         padding: const EdgeInsets.all(20.0),
          //         child: Container(height: 50, child: LoadingCircle()),
          //       );
          //     }
          //   },
          // ),
          Text(
            'Åbningstider:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Mandag'),
                  Text('Tirsdag'),
                  Text('Onsdag'),
                  Text('Torsdag'),
                  Text('Fredag'),
                  Text('Lørdag'),
                  Text('Søndag'),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              // FutureBuilder(
              //   future: _firestore
              //       .collection('applications')
              //       .document('LeosWok')
              //       .get(),
              //   //initialData: Text('Henter...'),
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     if (!snapshot.hasData)
              //       return Text('Login for at\nse åbningstider');
              //     if (snapshot.hasError)
              //       return Text('Der skete en fejl, Login og prøv igen.');
              //     else if (snapshot.connectionState == ConnectionState.waiting)
              //       return Text('Henter  ....');
              //     else {
              //       // return Text(snapshot.data.data.toString());

              //       ApplicationData appData =
              //           ApplicationData.fromJson(snapshot.data.data);
              //       print(appData.openingHours.length);

              Container(
                width: 100,
                child: ListView.builder(
                  itemCount: appData.openingHours.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<String> openStringList = appData.openingHours[index].toString().split('.');
                    List<String> closeStringList = appData.closingHours[index].toString().split('.');

                    String openHour = openStringList[0];
                    double tempOpenMinute = double.parse('0.' + openStringList[1]);
                    String openMinute = tempOpenMinute != 0.001 ? (tempOpenMinute * 60).round().toString() : '00';
                    String closeHour = closeStringList[0];
                    double tempCloseMinute = double.parse('0.' + closeStringList[1]);
                    String closeMinute = tempCloseMinute != 0.001 ? (tempCloseMinute * 60).round().toString() : '00';

                    String finalOpenHour = '$openHour:$openMinute - $closeHour:$closeMinute';

                    return Text(finalOpenHour != '0:00 - 0:00' ? finalOpenHour : 'Lukket');
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
              //     }
              //   },
              // )
            ],
          ),
          // Text('Mandag   16:00 – 20:00\nTirsdag    12:30 – 20:00\nOnsdag	   12:30 – 20:00\nTorsdag	   12:30 – 20:00\nFredag     	12:30 – 20:00\nLørdag	     12:30 – 20:00\nSøndag	    Lukket'),
        ],
      ),
    ));
  }

  // //TODO Skal man kunne skifte sprog?
  // Widget dropDownMenu() {
  //   return DropdownButton<String>(
  //     icon: Padding(
  //       padding: const EdgeInsets.only(right: 15.0),
  //       child: Icon(Icons.more_vert),
  //     ),
  //     isExpanded: true,
  //     underline: Container(
  //       height: 0,
  //     ),
  //     hint: ListTile(
  //       leading: Icon(Icons.language),
  //       title: Text('Select Language'),
  //       trailing: SizedBox(
  //         width: 75,
  //         child: Text(
  //           MealsLog.languageSelected,
  //           style: TextStyle(color: Colors.grey),
  //         ),
  //       ),
  //     ),
  //     // iconSize: 24,
  //     onChanged: (String newValue) {
  //       setState(() {
  //         MealsLog.languageSelected = newValue;
  //       });
  //     },
  //     items: <String>['Dansk', 'English']
  //         .map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //   );
  // }

  goToPage() {
    List<MenuItem> dummyList;
    print('login');

    // Navigator.push(context, MaterialPageRoute(builder: (context) => loginNextPage(dummyList, 'SettingsPage')));
  }

  _buildLogOutDialog() {
    showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            RaisedButton(
                child: Text('Log Out'),
                onPressed: () {
                  setState(() {
                    // _auth.logout();
                    Navigator.of(context).pop();
                  });
                })
          ],
        );
      },
      context: context,
    );
  }

  Widget settingsButton(Icon _tileIcon, String _tileTitle, VoidCallback _callback) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: RaisedButton.icon(
          color: Colors.grey[800],
          icon: _tileIcon,
          label: Text(_tileTitle),
          onPressed: _callback,
        ),
      ),
    );
  }
}
