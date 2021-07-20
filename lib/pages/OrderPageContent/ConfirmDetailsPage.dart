import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/Logic/CalculateValues.dart';
import 'package:restaurantorderapp/MyWidgets/LoadingCircle.dart';
import 'package:restaurantorderapp/MyWidgets/MyAlertDialog.dart';
import 'package:restaurantorderapp/MyWidgets/MyIconGridButton.dart';
import 'package:restaurantorderapp/flavors.dart';
import 'package:restaurantorderapp/model/ApplicationData.dart';
import 'package:restaurantorderapp/model/MeatChoice.dart';
import 'package:restaurantorderapp/model/OrderUser.dart';
import 'package:restaurantorderapp/pages/ReceiptPageContent/SingleReceiptPage.dart';
import '../../MyWidgets/MyAppBar.dart';
import '../../model/MenuItem.dart';
import '../../model/MealsLog.dart';
import '../../model/Order.dart';
import 'OrderReciept.dart';
import 'package:http/http.dart';
import 'package:ntp/ntp.dart';

class ConfirmDetailsPage extends StatefulWidget {
  final List<MenuItem> cartItems;
  // final FirebaseUser currentUser;
  final User currentUser;

  ConfirmDetailsPage(this.cartItems, this.currentUser);

  @override
  _ConfirmDetailsPageState createState() => _ConfirmDetailsPageState();
}

class _ConfirmDetailsPageState extends State<ConfirmDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController myController = TextEditingController();
  final CalculateValues _calculateValues = CalculateValues();
  OrderUser user = OrderUser(uid: 'uid', fullName: 'Name', phoneNr: 'Phone', email: 'E-mail');
  bool userLoaded = false;
  String orderMessage = 'Ingen kommentar til restaurenten.';
  String collectTimeMessage = 'Hurtigst muligt.';
  String serverToken = '';
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    var docRef = _firestore.collection('users').doc(widget.currentUser.uid);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: docRef.snapshots(),
                      builder: (BuildContext streamContext, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Container(height: 88, child: LoadingCircle());
                        else if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else {
                          user = OrderUser.fromJson(snapshot.data!.data() as Map<String, dynamic>);

                          if (!userLoaded) {
                            Future.delayed(Duration.zero, () {
                              setState(() {
                                userLoaded = true;
                                print('update!');
                              });
                            });
                          }
                          return MyIconGridButton(
                            title: user.fullName,
                            url: 'url',
                            icon: Icon(Icons.person, color: Colors.white),
                            subtitle: '${user.email}\n${user.phoneNr}',
                            canTap: false,
                          );
                          // return ListTile(
                          //   title: Text(user.fullName),
                          //   subtitle: Text(user.phoneNr + '\n' + user.email),
                          //   isThreeLine: true,
                          // );
                        }
                      },
                    ),
                    OrderReciept(widget.cartItems),
                    Container(
                      padding: EdgeInsets.all(4),
                      width: double.infinity,
                      child: ElevatedButton(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(text: 'Kommentar:\n', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), children: [
                              TextSpan(
                                text: orderMessage,
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                              )
                            ]),
                          ),
                          onPressed: () {
                            _buildAddMessageDialog(context);
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      width: double.infinity,
                      child: ElevatedButton(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(text: 'Afhent tid:\n', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), children: [
                              TextSpan(
                                text: collectTimeMessage,
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                              )
                            ]),
                          ),
                          onPressed: () {
                            _buildCollectTimeDialog(context);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Spacer(),
          userLoaded
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4),
                  // height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        confirmOrder();
                      },
                      child: Text('Bekræft og send ordre')),
                )
              : Container(
                  height: 60,
                  child: Center(
                    child: Text('Venter på bruger...'),
                  )),
          // SizedBox(
          //   height: 30,
          // )
        ],
      ),
    );
  }

  Future<List<String>> _createCollectTimeList() async {
    DateTime currentDate = await NTP.now();
    // List<double> openCloseHour = await _calculateValues.getTodaysOpenCloseHour(currentDate);
    List<double> openCloseHour = [14,01];
    List<String> timeList = [
      'Hurtigst muligt',
    ];

    DateTime tempDate = currentDate.add(Duration(minutes: 15));
    int startMinute = tempDate.minute;
    // int startMinute = 59;

    print(openCloseHour);
    print('startMinute: $startMinute');
    print('startMinute round: ${(startMinute / 15).floor()}');

    for (var i = tempDate.hour; i < 24; i++) {
      if ((i > openCloseHour[0] && i < openCloseHour[1]) || (i > openCloseHour[0] && openCloseHour[0] > openCloseHour[1])) {
        for (var j = (startMinute / 15).ceil(); j < 4; j++) {
          double dateIndex = i + j / 100;
          if ((dateIndex > openCloseHour[0] && dateIndex < openCloseHour[1]) ||
              (dateIndex > openCloseHour[0] && openCloseHour[0] > openCloseHour[1])) {
            timeList.add('${i.toString().padLeft(2, '0')}:${(j * 15).toString().padLeft(2, '0')}');
          }
        }
          startMinute = 0;
      }
    }
    return timeList;
  }

  _buildCollectTimeDialog(BuildContext context) async {
    // DateTime currentDate = await NTP.now();
    // List<double> openCloseHour = await _calculateValues.getTodaysOpenCloseHour(currentDate);
    // List<String> timeList = [
    //   'Hurtigst muligt',
    // ];

    // DateTime tempDate = currentDate.add(Duration(minutes: 15));
    // int startMinute = tempDate.minute;

    // for (var i = tempDate.hour; i < 24; i++) {
    //   if ((i > openCloseHour[0] && i < openCloseHour[1]) || (i > openCloseHour[0] && openCloseHour[0] > openCloseHour[1])) {
    //     for (var j = (startMinute / 15).ceil(); j < 4; j++) {
    //       startMinute = 0;
    //       double dateIndex = i + j / 100;
    //       if ((dateIndex > openCloseHour[0] && dateIndex < openCloseHour[1]) ||
    //           (dateIndex > openCloseHour[0] && openCloseHour[0] > openCloseHour[1])) {
    //         timeList.add('${i.toString().padLeft(2, '0')}:${(j * 15).toString().padLeft(2, '0')}');
    //       }
    //     }
    //   }
    // }
    _createCollectTimeList().then((timeList) {
      print(timeList);
      showDialog(
        context: context,
        builder: (context) {
          String selectedValue = 'Hurtigst muligt.';
          return MyAlertDialog(
            title: 'Vælg afhentnings tid.',
            content: Container(
              height: 200,
              child: CupertinoPicker.builder(
                // magnification: 1.2,
                childCount: timeList.length,
                itemExtent: 40,
                onSelectedItemChanged: (value) => selectedValue = timeList[value],
                itemBuilder: (context, index) {
                  return Center(child: Text(timeList[index]));
                },
              ),
            ),
            cancelText: 'Luk',
            myOnPressed: () {
              setState(() {
                collectTimeMessage = selectedValue;
              });
              Navigator.of(context).pop();
            },
            confirmText: 'Bekræft',
          );
        },
      );
    });
  }

  //dialog to add comment to order.
  _buildAddMessageDialog(BuildContext context) {
    showDialog(
      builder: (context) {
        return MyAlertDialog(
          title: 'Tilføj kommentar',
          content: Container(
            height: 120,
            color: Colors.grey[100],
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.normal),
              scrollPadding: EdgeInsets.all(0),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              maxLines: 5,
              controller: myController,
            ),
          ),
          cancelText: 'Luk',
          myOnPressed: () {
            setState(() {
              orderMessage = myController.text;
            });
            Navigator.of(context).pop();
          },
          confirmText: 'Bekræft',
        );
      },
      context: context,
    );
  }

//Bekræft og send ordre button
  void confirmOrder() async {
    showDialog(
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Center(child: CircularProgressIndicator()),
        );
      },
      context: context,
    );
    try {
      DateTime currentDate = await NTP.now();
      // DateTime currentDate = DateTime.now();
      // DateTime currentDate = DateTime(2020, 09, 25, 11, 02);
      isOpen = await _calculateValues.checkIfWithinOpenHours(currentDate);
      List<String> collectTimeList = collectTimeMessage.split(':');
      String wantOrderTime = '0';
      if (collectTimeList.length > 0) {
        DateTime wantOrderDateTime =
            DateTime(currentDate.year, currentDate.month, currentDate.day, int.parse(collectTimeList[0]), int.parse(collectTimeList[1]));
        wantOrderTime = wantOrderDateTime.millisecondsSinceEpoch.toString();
      }

      DocumentSnapshot applicationDataSnapshot = await _firestore.doc('${F.firestoreCollection}').get();
      ApplicationData appData = ApplicationData.fromJson(applicationDataSnapshot.data() as Map<String, dynamic>);

      // if (true) {
      if (isOpen && appData.versionId == 1) {
        //Create Order
        String orderDate = currentDate.millisecondsSinceEpoch.toString();
        Order tempFinalOrder = Order(
            menuOrder: widget.cartItems,
            user: user,
            orderDate: orderDate,
            orderDone: false,
            orderAccepted: false,
            acceptTime: '0',
            wantOrderTime: wantOrderTime,
            restaurantMessage: 'Ingen besked.',
            orderMessage: orderMessage);
        tempFinalOrder.menuOrder.forEach((mo) {
          List<MeatChoice> newMeatchoice = [];
          if (mo.meatChoice.length != 0) {
            mo.meatChoice.forEach((mc) {
              newMeatchoice.add(MeatChoice.clone(mc));
            });
            mo.meatChoice = newMeatchoice;
          }
        });

        Order finalOrder = Order.clone(tempFinalOrder);

        // widget.cartItems.forEach((e) {
        //   finalOrder.menuOrder.add(MenuItem(
        //       e.id, e.title, e.description, e.price, e.image, e.amount,
        //       meatChoice: e.meatChoice??null));
        // });

        String dateString = _calculateValues.dateStringFromMili(orderDate);

        await postToFireStore(finalOrder, orderDate);
        await sendAndRetrieveMessage(orderDate, appData.deviceToken);

        MealsLog.pageIndex = 2;

        resetMenuItems();

        Navigator.push(context, MaterialPageRoute(builder: (context) => SingleReceiptPage(finalOrder, dateString, true), fullscreenDialog: true));
      } else if (!isOpen) {
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => MyHomePage()),
        //     (Route<dynamic> route) => false);
        Navigator.of(context).pop();
        _buildDialog(context, 'Restauranten er lukket', 'Se åbningstider på info siden.');
      } else {
        Navigator.of(context).pop();
        _buildDialog(context, 'Din app er outdated', 'Du skal opdatere din app til den nyeste version, inden du kan lave en bestilling.');
      }
    } catch (e) {
      Navigator.of(context).pop();
      print('Error: ${e.toString()}');
      _buildDialog(context, 'Der skete en fejl', 'Der kan ikke forbindes til serveren.');
    }
  }

  Future _buildDialog(BuildContext context, String _title, String _message) {
    return showDialog(
      builder: (context) {
        return MyAlertDialog(
          title: _title,
          content: Text(_message, textAlign: TextAlign.center),
          cancelText: 'Ok',
          myOnPressed: () {},
          infoDialog: true,
        );
      },
      context: context,
    );
  }

  resetMenuItems() {
    print('reset');
    MealsLog.totalPrice = 0;
    MealsLog.allMenus.forEach((element) {
      clearMenuItems(element);
    });
  }

  void clearMenuItems(List<MenuItem> menuItems) {
    menuItems.forEach((element) {
      element.amount = 0;
      if (element.meatChoice != null) {
        element.meatChoice.forEach((meat) => meat.amount = 0);
      }
    });
  }

//Send post norification to client app with device id
  Future<bool> sendAndRetrieveMessage(String orderDate, String deviceToken) async {
    print(deviceToken);
    await post(
      Uri.parse(F.baseURL + '/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${F.serverToken}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': 'Ny Ordre!',
            'body': 'Ordre fra ${user.fullName}, tlf: ${user.phoneNr}',
            'sound': 'OrderSound.caf',
            'badge': '1',
          },
          'priority': 'high',
          'data': <String, dynamic>{'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'id': orderDate, 'status': 'done'},
          'to': deviceToken,
        },
      ),
    ).then((value) {
      print('notification sucess');
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
    return false;
  }

//Send order to database
  Future<bool> postToFireStore(Order finalOrder, String orderDate) async {
    print('Sending to db');

    List<Map<String, dynamic>> finalMenuOrder = [];
    finalOrder.menuOrder.forEach((element) {
      finalMenuOrder.add(element.toJson());
    });

    var docpostRef = _firestore.collection('${F.firestoreCollection}/orders');

    await docpostRef.doc(orderDate).set({
      'menuOrder': finalMenuOrder,
      'user': finalOrder.user.toJson(),
      'orderDate': finalOrder.orderDate,
      'orderDone': finalOrder.orderDone,
      'orderAccepted': finalOrder.orderAccepted,
      'acceptTime': finalOrder.acceptTime,
      'restaurantMessage': finalOrder.restaurantMessage,
      'orderMessage': finalOrder.orderMessage,
    }).then((value) {
      print('db: success!');
      return true;
    }).catchError((onError) {
      print('db error: ' + onError.toString());
      return false;
    });
    return false;
  }
}
