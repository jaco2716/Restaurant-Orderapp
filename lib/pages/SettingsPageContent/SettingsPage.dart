// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/Login/AuthService.dart';
import 'package:restaurantorderapp/Login/LoginPage.dart';
import 'package:restaurantorderapp/MyWidgets/LoadingCircle.dart';

// import '../../Login/LoadingCircle.dart';
// import '../../LoginPageProvider.dart';
import '../../LoginPageProvider.dart';
import '../../model/ApplicationData.dart';
import '../../model/MenuItem.dart';
// import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

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
  AuthService _auth = AuthService();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _signedIn = false;

  void checkLoginStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          _signedIn = false;
        });
      } else {
        print('User is signed in!');
        _signedIn = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 150,
            width: double.infinity,
            child: Image.asset(F.appIconPathDark),
          ),
          Container(
            child: GridView.count(
              childAspectRatio: 2.5,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                infoGridButton('Website', F.companyWebsite, Icon(Icons.web), subtitle: F.companyWebsite),
                infoGridButton('Phone', 'tel:${F.companyPhone.replaceAll(' ', '')}', Icon(Icons.phone), subtitle: F.companyPhone),
                infoGridButton('Address', 'https://www.google.com/maps/place/${F.companyAddress.replaceAll(' ', '+')}', Icon(Icons.pin_drop),
                    subtitle: F.companyAddress),
                infoGridButton('Privacy Policy', F.privacyPolicyURL, Icon(Icons.privacy_tip)),
              ],
            ),
          ),
          // TextButton(
          //     style: TextButton.styleFrom(
          //       primary: Colors.blue,
          //     ),
          //     onPressed: () async {
          //       dynamic res = await urlLauncher.launch(F.companyWebsite);
          //       print('call: ' + res.toString());
          //     },
          //     child: Text(F.companyWebsite)),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 10.0),
          //   child: ElevatedButton.icon(
          //       icon: Icon(Icons.phone),
          //       onPressed: () async {
          //         String _url = 'tel:${F.companyPhone.replaceAll(' ', '')}';

          //         dynamic res = await urlLauncher.launch(_url);
          //         print('call: ' + res.toString());
          //       },
          //       label: Text(F.companyPhone)),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
          //   child: Text(
          //     F.companyAddress,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // TextButton(
          //     style: TextButton.styleFrom(primary: Colors.blue),

          //     // textColor: Colors.blue[300],
          //     onPressed: () async {
          //       await urlLauncher.launch(F.privacyPolicyURL);
          //     },
          //     child: Text('Privacy Policy')),
          Card(
              color: F.appSecondaryColor[900],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                child: Column(children: [
                  Text(
                    'Åbningstider:',
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, fontSize: 22),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 1,
                    width: 220,
                    color: Colors.white,
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mandag\nTirsdag\nOnsdag\nTorsdag\nFredag\nLørdag\nSøndag',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Container(height: 110, width: 1, color: Colors.white),
                        FutureBuilder<DocumentSnapshot>(
                          future: _firestore.doc('${F.baseURL}').get(),
                          //initialData: Text('Henter...'),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Text(
                                'Login for at\nse åbningstider',
                                style: TextStyle(color: Colors.white),
                              );
                            else if (snapshot.hasError)
                              return Text(
                                'Der skete en fejl,\nLogin og prøv igen.',
                                style: TextStyle(color: Colors.white),
                              );
                            else if (snapshot.connectionState == ConnectionState.waiting)
                              return SizedBox(
                                width: 100,
                                child: LoadingCircle(
                                  color: Colors.white,
                                ),
                              );
                            else if (snapshot.data!.data() == null)
                              return Text(
                                'Der skete en fejl.',
                                style: TextStyle(color: Colors.white),
                              );
                            else {
                              //TODO create easy open hours...

                              ApplicationData appData = ApplicationData.fromJson(snapshot.data!.data() as Map<String, dynamic>);

                              return Container(
                                width: 100,
                                child: ListView.builder(
                                  itemCount: appData.openingHours.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    String openHour;
                                    String closeHour;
                                    double openhourDouble = (appData.openingHours[index] / 100);
                                    appData.openingHours[index] < 1000 ? openHour = '0' : openHour = '';
                                    openHour += openhourDouble.toStringAsFixed(2).replaceAll('.', ':');
                                    double closehourDouble = (appData.closingHours[index] / 100);
                                    appData.closingHours[index] < 1000 ? closeHour = '0' : closeHour = '';
                                    closeHour += closehourDouble.toStringAsFixed(2).replaceAll('.', ':');
                                    String finalOpenHour = '$openHour - $closeHour';
                                    return Text(
                                      finalOpenHour != '00:00 - 00:00' ? finalOpenHour : 'Lukket',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Colors.white),
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ]),
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
            child: FutureBuilder<dynamic>(
              future: _auth.getUser(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.error != null) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    return settingsButton(Icon(Icons.lock), "Logout", _buildLogOutDialog);
                  } else {
                    return settingsButton(Icon(Icons.lock_open), "Login", goToPage);
                  }
                } else {
                  // show loading indicator
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(height: 50, child: LoadingCircle()),
                  );
                }
              },
            ),
          ),
          // ElevatedButton(onPressed: () => createOpenHours(), child: Text('create app data')),
        ],
      ),
    ));
  }

  goToPage() {
    List<MenuItem> dummyList = [];
    print('login');
    Navigator.push(context, MaterialPageRoute(builder: (context) => loginNextPage(dummyList, 'SettingsPage')));
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
                    _auth.logout();
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
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: F.appPrimaryColor[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        icon: _tileIcon,
        label: Text(_tileTitle),
        onPressed: _callback,
      ),
    );
  }

  // void createOpenHours() {
  //   ApplicationData appDataTemp = ApplicationData(
  //       closingHours: [2100, 2100, 2100, 2100, 2100, 2100, 2100],
  //       openingHours: [1100, 1100, 1100, 1100, 1100, 1100, 1100],
  //       versionId: 1,
  //       deviceToken: '123');
  //   _firestore.doc('${F.baseURL}').set(appDataTemp.toJson());
  // }

  Widget infoGridButton(String title, String url, Icon icon, {String? subtitle}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(5),
        ),
        onPressed: () async {
          bool canLaunch = await urlLauncher.canLaunch(url);
          if (canLaunch) {
            await urlLauncher.launch(url);
          }
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: F.appSecondaryColor[900],
                child: icon,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(text: title),
                      subtitle != null
                          ? TextSpan(
                              text: '\n$subtitle',
                              style: TextStyle(color: Colors.black87, fontSize: 8, fontWeight: FontWeight.w300),
                            )
                          : TextSpan(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
