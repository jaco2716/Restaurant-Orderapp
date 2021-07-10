import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/MyWidgets/LoadingCircle.dart';
import 'package:restaurantorderapp/model/OrderUser.dart';
import '../../MyWidgets/MyAppBar.dart';
import '../../model/MenuItem.dart';
import '../../model/MealsLog.dart';
import '../../model/Order.dart';
import 'OrderConfirmation.dart';

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
  OrderUser user = OrderUser(uid: 'uid', fullName: 'Name', phoneNr: 'Phone', email: 'E-mail');
  bool userLoaded = false;
  String orderMessage = 'Ingen kommentar til restaurenten.';
  String serverToken = '';
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    var docRef = _firestore.collection('users').doc(widget.currentUser.uid);
    return Scaffold(
      appBar: MyAppBar('Bekræft Ordre'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: docRef.snapshots(),
                builder: (BuildContext streamContext,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                    return ListTile(
                      title: Text(user.fullName),
                      subtitle: Text(user.phoneNr + '\n' + user.email),
                      isThreeLine: true,
                    );
                  }
                },
              ),
              OrderConfirmation(widget.cartItems),
              Container(
                height: 60,
                padding: EdgeInsets.all(4),
                width: double.infinity,
                child: RaisedButton(
                    elevation: 0,
                    child: Text('Tilføj kommentar til ordren.'),
                    color: Colors.blue,
                    onPressed: () {
                      _buildAddMessageDialog(context);
                    }),
              ),
              Card(
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(children: [
                        Text(
                          'Kommentar:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          orderMessage,
                          textAlign: TextAlign.center,
                        )
                      ]))),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4),
                height: 60,
                child: RaisedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Demo'),
                            content: Text('Demo versionen kan ikke lave ordrer.'),
                            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Ok'))],
                          );
                        },
                      );
                      // confirmOrder();
                    },
                    child: Text('Bekræft og send ordre')),
              ),
              // userLoaded
              //     ? Container(
              //         width: double.infinity,
              //         padding: EdgeInsets.all(4),
              //         height: 60,
              //         child: RaisedButton(
              //             onPressed: () {
              //               // confirmOrder();
              //             },
              //             child: Text('Bekræft og send ordre')),
              //       )
              //     : Container(
              //         height: 60,
              //         child: Center(
              //           child: Text('Venter på bruger...'),
              //         )),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

//Skal måske bruges senere, hvis man skal vælge hvornår man vil hente maden.
  // _buildSelectTime() {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         color: Colors.white,
  //         height: 200,
  //         child: CupertinoDatePicker(
  //           use24hFormat: true,
  //           initialDateTime: isOpen? currentDate : todayOpenDate,
  //           minimumDate: isOpen? currentDate : todayOpenDate,
  //           maximumDate: todayClosingDate,
  //           minuteInterval: 1,
  //           mode: CupertinoDatePickerMode.dateAndTime,
  //           onDateTimeChanged: (DateTime dateTime) {
  //             print("dateTime: $dateTime");
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  //dialog to add comment to order.
  _buildAddMessageDialog(BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Tilføj kommentar'),
          content: Container(
            height: 120,
            color: Colors.grey[100],
            child: TextField(
              scrollPadding: EdgeInsets.all(0),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              maxLines: 5,
              controller: myController,
              //minLines: 3,
            ),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('Luk'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            RaisedButton(
                child: Text('Tilføj'),
                onPressed: () {
                  setState(() {
                    orderMessage = myController.text;
                  });
                  Navigator.of(context).pop();
                })
          ],
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
      // DateTime currentDate = await NTP.now();
      //DateTime currentDate = DateTime(2020, 09, 25, 11, 02);
      // isOpen = await CalculateValues.checkIfWithinOpenHours(currentDate);

      // DocumentSnapshot applicationDataSnapshot =
      //     await _firestore.collection('applications').document('LeosWok').get();
      // ApplicationData appData =
      //     ApplicationData.fromJson(applicationDataSnapshot.data);

      // if (isOpen && appData.versionId == 1) {
      //   //Create Order
      //   String orderDate = DateTime.now().millisecondsSinceEpoch.toString();
      //   Order finalOrder = Order(
      //       menuOrder: widget.cartItems,
      //       user: user,
      //       orderDate: orderDate,
      //       orderDone: false,
      //       orderAccepted: false,
      //       acceptTime: '0',
      //       restaurantMessage: 'No message',
      //       orderMessage: orderMessage);
      //   finalOrder.menuOrder.forEach((mo) {
      //     List<MeatChoice> newMeatchoice = List<MeatChoice>();
      //     if (mo.meatChoice != null) {
      //       mo.meatChoice.forEach((mc) {
      //         newMeatchoice.add(MeatChoice.clone(mc));
      //       });
      //       mo.meatChoice = newMeatchoice;
      //     }
      //   });

      //   //Order finalOrder = Order.clone(tempFinalOrder);

      //   // print('Order copy: ${finalOrder.orderDone.toString()} - ${newOrderfinal.orderDone.toString()}');
      //   // finalOrder.orderDone = true;
      //   // print('copy after change: ${finalOrder.orderDone.toString()} - ${newOrderfinal.orderDone.toString()}');

      //   // widget.cartItems.forEach((e) {
      //   //   finalOrder.menuOrder.add(MenuItem(
      //   //       e.id, e.title, e.description, e.price, e.image, e.amount,
      //   //       meatChoice: e.meatChoice??null));
      //   // });

      //   String dateString = CalculateValues.dateStringFromMili(orderDate);

      //   await postToFireStore(finalOrder, orderDate);
      //   await sendAndRetrieveMessage(orderDate, appData.deviceToken);

      //   MealsLog.pageIndex = 2;
      //   // print('Before make order: ' + finalOrder.menuOrder[0].toString());
      //   // finalOrder.menuOrder[0].meatChoice.forEach((element) {
      //   //   print('before meat amount' + element.amount.toString());
      //   // });

      //   resetMenuItems();

      //   // print('Make Order with: ' + finalOrder.menuOrder[0].toString());
      //   // finalOrder.menuOrder[0].meatChoice.forEach((element) {
      //   //   print('after meat amount' + element.amount.toString());
      //   // });
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               SingleReceiptPage(finalOrder, dateString, true),
      //           fullscreenDialog: true));

      //   // Future.delayed(Duration(seconds: 4), () {
      //   //   resetMenuItems();
      //   // });
      // } else if (!isOpen) {
      //   // Navigator.of(context).pushAndRemoveUntil(
      //   //     MaterialPageRoute(builder: (context) => MyHomePage()),
      //   //     (Route<dynamic> route) => false);
      //   Navigator.of(context).pop();
      //   _buildDialog(context, 'Restauranten er lukket',
      //       'Se åbningstider på info siden.');
      // } else {
      //   Navigator.of(context).pop();
      //   _buildDialog(context, 'Din app er outdated',
      //       'Du skal opdatere din app til den nyeste version, inden du kan lave en bestilling.');
      // }
    } catch (e) {
      Navigator.of(context).pop();
      print('Error: ${e.toString()}');
      _buildDialog(context, 'Der skete en fejl', 'Der kan ikke forbindes til serveren.');
    }
  }

  Future _buildDialog(BuildContext context, String _title, String _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(
            _title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            _message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

  resetMenuItems() {
    print('reset');
    MealsLog.totalPrice = 0;
    //TODO = DONE? Change to final static lists
    MealsLog.allMenus.forEach((element) {
      clearMenuItems(element);
    });
    // clearMenuItems(MealsLog.smallMeals);
    // clearMenuItems(MealsLog.soups);
    // clearMenuItems(MealsLog.noodlesAndFriedRice);
    // clearMenuItems(MealsLog.mainMealWithRice);
    // clearMenuItems(MealsLog.specialMealsWithRice);
    // clearMenuItems(MealsLog.vegetaryVeganMeals);
    // clearMenuItems(MealsLog.salads);
    // clearMenuItems(MealsLog.childMeals);
    // clearMenuItems(MealsLog.childMeals2);
    // clearMenuItems(MealsLog.dersert);
    // clearMenuItems(MealsLog.accessoriesItems);
    // clearMenuItems(MealsLog.hotDrinks);
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
  // Future<bool> sendAndRetrieveMessage(
  //     String orderDate, String deviceToken) async {
  //   print(deviceToken);
  //   await post(
  //     config.baseURL + '/fcm/send',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=${config.serverToken}',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'notification': <String, dynamic>{
  //           'title': 'Ny Ordre!',
  //           'body': 'Ordre fra ${user.fullName}, tlf: ${user.phoneNr}',
  //           'sound': 'LeosWokSound.caf',
  //           'badge': '1',
  //         },
  //         'priority': 'high',
  //         'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'id': orderDate,
  //           'status': 'done'
  //         },
  //         'to': deviceToken,
  //       },
  //     ),
  //   ).then((value) {
  //     print('notification sucess');
  //     return true;
  //   }).catchError((error) {
  //     print(error);
  //     return false;
  //   });
  //   return false;
  // }

//Send order to database
  Future<bool> postToFireStore(Order finalOrder, String orderDate) async {
    //print('Sending to db');

    List<Map<String, dynamic>> finalMenuOrder = [];
    finalOrder.menuOrder.forEach((element) {
      finalMenuOrder.add(element.toJson());
    });
    return false;

    // var docpostRef = _firestore.collection('orders');

    // await docpostRef.document(orderDate).setData({
    //   'menuOrder': finalMenuOrder,
    //   'user': finalOrder.user.toJson(),
    //   'orderDate': finalOrder.orderDate,
    //   'orderDone': finalOrder.orderDone,
    //   'orderAccepted': finalOrder.orderAccepted,
    //   'acceptTime': finalOrder.acceptTime,
    //   'restaurantMessage': finalOrder.restaurantMessage,
    //   'orderMessage': finalOrder.orderMessage,
    // }).then((value) {
    //   print('db: success!');
    //   return true;
    // }).catchError((onError) {
    //   print('db error: ' + onError.toString());
    //   return false;
    // });
    // return false;
  }
}
