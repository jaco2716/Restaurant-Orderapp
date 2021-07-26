import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/Logic/AuthService.dart';
import 'package:restaurantorderapp/MyWidgets/LoadingCircle.dart';
import 'package:restaurantorderapp/MyWidgets/MyAlertDialog.dart';
import 'package:restaurantorderapp/MyWidgets/MyAppBar.dart';
import 'package:restaurantorderapp/MyWidgets/MyIconGridButton.dart';
import 'package:restaurantorderapp/model/NextPageEnum.dart';
import 'package:restaurantorderapp/pages/LoginPageContent/CheckLoginPage.dart';
import '../../model/ApplicationData.dart';
import '../../flavors.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? myUser;

  @override
  void initState() {
    myUser = _auth.currentUser;
    _auth.authStateChanges().listen((User? user) => mounted ? setState(() => myUser = user) : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          myUser == null
              ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      height: 100,
                      width: double.infinity,
                      child: Image.asset(F.appIconPathDark),
                    ),
                    settingsButton(Icon(Icons.lock_open), "Sign in ", goToPage)
                  ],
                )
              : userInfoTile(),
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
                MyIconGridButton(title: 'Website', url: F.companyWebsite, icon: Icon(Icons.web), subtitle: F.companyWebsite),
                MyIconGridButton(title: 'Phone', url: 'tel:${F.companyPhone.replaceAll(' ', '')}', icon: Icon(Icons.phone), subtitle: F.companyPhone),
                MyIconGridButton(
                    title: 'Address',
                    url: 'https://www.google.com/maps/place/${F.companyAddress.replaceAll(' ', '+')}',
                    icon: Icon(Icons.pin_drop),
                    subtitle: F.companyAddress),
                MyIconGridButton(title: 'Privacy Policy', url: F.privacyPolicyURL, icon: Icon(Icons.privacy_tip)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Card(
                color: F.appSecondaryColor[900],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
                  child: Column(children: [
                    Text(
                      'Åbningstider:',
                      style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, fontSize: 22),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    Container(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mandag  \nTirsdag  \nOnsdag  \nTorsdag  \nFredag  \nLørdag  \nSøndag',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          // Container(height: 110, width: 1, color: Colors.white70),
                          FutureBuilder<DocumentSnapshot>(
                            future: _firestore.doc('${F.firestoreCollection}').get(),
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
                                        // textAlign: TextAlign.right,
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
          ),
          // myUser == null
          //     ? settingsButton(Icon(Icons.lock_open), "Sign in ", goToPage)
          //     : settingsButton(Icon(Icons.lock), "Sign out", _buildLogOutDialog),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
          //   child: FutureBuilder<dynamic>(
          //     future: _auth.getUser(),
          //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         if (snapshot.error != null) {
          //           return Text(snapshot.error.toString());
          //         }
          //         if (snapshot.hasData) {
          //           return settingsButton(Icon(Icons.lock), "Sign out", _buildLogOutDialog);
          //         } else {
          //           return settingsButton(Icon(Icons.lock_open), "Sign in ", goToPage);
          //         }
          //       } else {
          //         // show loading indicator
          //         return Padding(
          //           padding: const EdgeInsets.all(20.0),
          //           child: Container(height: 50, child: LoadingCircle()),
          //         );
          //       }
          //     },
          //   ),
          // ),
          // ElevatedButton(onPressed: () => createOpenHours(), child: Text('create app data')),
        ],
      ),
    ));
  }

  goToPage() {
    print('Sign in');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(appBar: MyAppBar('Sign in'), body: CheckLoginPage(NextPage.SettingsPage, 'Sign in.. .', []))));
    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())).then((value) {
    //   setState(() {});
    // });
  }

  _buildLogOutDialog() {
    showDialog(
      builder: (context) {
        return MyAlertDialog(
          title: 'Sign out',
          content: Text('Er du sikker på du vil logge ud?', textAlign: TextAlign.center),
          cancelText: 'Annuller',
          myOnPressed: () {
            _authService.logout();
            Navigator.of(context).pop();
            // setState(() {
            // });
          },
          confirmText: 'Bekræft',
        );
      },
      context: context,
    );
  }

  Widget userInfoTile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Logget ind som:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          MyIconGridButton(
            title: '${myUser?.displayName ?? 'Navn'}',
            url: 'url',
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            subtitle:
                '${myUser?.email ?? 'E-mail'}                                                                                                               ',
            canTap: false,
            trailing: IconButton(onPressed: () => _buildLogOutDialog(), icon: Icon(Icons.logout_rounded, color: Colors.black)),
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }

  Widget settingsButton(Icon _tileIcon, String _tileTitle, VoidCallback _callback) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      width: double.infinity,
      height: 70,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: F.appSecondaryColor[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
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
  //   _firestore.doc('${F.firestoreCollection}').set(appDataTemp.toJson());
  // }

  // Widget infoGridButton(String title, String url, Icon icon, {String? subtitle, bool canTap = true, Widget? trailing}) {
  //   return ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         primary: Colors.white,
  //         onSurface: Colors.white,
  //         elevation: 0,
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         padding: EdgeInsets.all(5),
  //       ),
  //       onPressed: canTap
  //           ? () async {
  //               bool canLaunch = await urlLauncher.canLaunch(url);
  //               if (canLaunch) {
  //                 await urlLauncher.launch(url);
  //               }
  //             }
  //           : null,
  //       child: Row(
  //         mainAxisSize: MainAxisSize.max,
  //         children: [
  //           Container(
  //             height: 50,
  //             width: 50,
  //             child: Card(
  //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //               color: F.appSecondaryColor[900],
  //               child: icon,
  //             ),
  //           ),
  //           Flexible(
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 5),
  //               child: RichText(
  //                 text: TextSpan(
  //                   style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
  //                   children: [
  //                     TextSpan(text: title),
  //                     subtitle != null
  //                         ? TextSpan(
  //                             text: '\n$subtitle',
  //                             style: TextStyle(color: Colors.black87, fontSize: 8, fontWeight: FontWeight.w300),
  //                           )
  //                         : TextSpan(),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           trailing == null ? Center() : trailing,
  //         ],
  //       ));
  // }
}
