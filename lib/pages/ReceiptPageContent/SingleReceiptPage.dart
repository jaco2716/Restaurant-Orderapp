import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/MyWidgets/MyAlertDialog.dart';
import 'package:restaurantorderapp/MyWidgets/MyIconGridButton.dart';
import 'package:restaurantorderapp/model/MenuItem.dart';
import 'package:restaurantorderapp/model/NextPageEnum.dart';
import 'package:restaurantorderapp/model/Order.dart';
import 'package:restaurantorderapp/pages/LoginPageContent/CheckLoginPage.dart';
import 'package:restaurantorderapp/pages/OrderPageContent/OrderReciept.dart';
import '../../flavors.dart';
import '../my_home_page.dart';
import '/../MyWidgets/LoadingCircle.dart';
import '/../MyWidgets/MyAppBar.dart';
import '../../Logic/CalculateValues.dart';

class SingleReceiptPage extends StatefulWidget {
  final Order order;
  final String dateString;
  final bool fromMakeOrder;

  SingleReceiptPage(this.order, this.dateString, this.fromMakeOrder);

  @override
  _SingelOrderPageState createState() => _SingelOrderPageState();
}

class _SingelOrderPageState extends State<SingleReceiptPage> {
  int timeAmount = 15;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool showOrderAgain = false;
  bool hasRefreshed = false;
  final CalculateValues _calculateValues = CalculateValues();

  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    DocumentReference docRef = _firestore.collection('${F.firestoreCollection}/orders').doc(widget.order.orderDate);

    return Scaffold(
      appBar: !widget.fromMakeOrder
          ? MyAppBar('Nr: ${widget.order.orderDate}')
          : AppBar(
              backgroundColor: F.appPrimaryColor[900],
              title: Text('Nr: ${widget.order.orderDate}'),
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (Route<dynamic> route) => false);
                },
              ),
            ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              MyIconGridButton(
                title: '${widget.order.user.fullName}',
                url: 'url',
                icon: Icon(Icons.person, color: Colors.white),
                subtitle: '${widget.order.user.phoneNr} \n${widget.order.user.email}',
                canTap: false,
              ),
              // widget.order.orderAccepted
              //     ? orderConfirmed()
              //     : widget.order.orderDone
              //         ? orderDeclined()
              //         : waitingForResponse(),
              StreamBuilder<DocumentSnapshot>(
                stream: docRef.snapshots(),
                builder: (BuildContext streamContext, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Container(height: 88, child: LoadingCircle());
                  else if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else {
                    Order orderStream = Order.fromJson(snapshot.data?.data() as Map<String, dynamic>);
                    Future.delayed(Duration.zero, () {
                      if (orderStream.orderAccepted && !showOrderAgain) {
                        setState(() {
                          showOrderAgain = true;
                          // print('update!!');
                          widget.order.restaurantMessage = orderStream.restaurantMessage;
                          widget.order.acceptTime = orderStream.acceptTime;
                        });
                      }
                      if (orderStream.orderDone && !hasRefreshed) {
                        setState(() {
                          hasRefreshed = true;
                          // print('update!!');
                          widget.order.restaurantMessage = orderStream.restaurantMessage;
                        });
                      }
                    });
                    // print(widget.order.menuOrder.toString());
                    // return orderStatus();
                    return orderStream.orderAccepted
                        ? orderConfirmed()
                        : orderStream.orderDone
                            ? orderDeclined()
                            : waitingForResponse();
                  }
                },
              ),

              //Text(widget.order.orderDate),
              // widget.order.orderAccepted
              //     ? orderConfirmed()
              //     : widget.order.orderDone
              //         ? orderDeclined()
              //         : waitingForResponse(),

              // Card(
              //   elevation: 5,
              //   child: ListTile(
              //     title: Text('Navn: ${widget.order.user.fullName}'),
              //     subtitle: Text('Tlf: ${widget.order.user.phoneNr} \nE-mail: ${widget.order.user.email}'),
              //   ),
              // ),
              // Divider(),
              // Text('Bestilt ${widget.dateString}'),
              OrderReciept(widget.order.menuOrder),
              SizedBox(
                height: 15,
              ),
              showOrderAgain
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4),
                      height: 60,
                      child: ElevatedButton(
                          child: Text('Bestil igen!'),
                          onPressed: () {
                            //TODO test order again
                            try {
                              bool canReorder = checkIfCanReorder();
                              if (canReorder) {
                                print('MenuItems are the same');

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Scaffold(appBar: MyAppBar(''),body: CheckLoginPage(NextPage.OrderPage, 'Sing in for at se dine ordrer.', widget.order.menuOrder))));
                              } else {
                                print('Somwthing went wrong');
                                _showCantReorderDialog();
                              }
                            } catch (e) {
                              print(e);
                              _showCantReorderDialog();
                            }
                          }),
                    )
                  : Center(),
            ],
          ),
        ),
      ),
    );
  }

  void _showCantReorderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertDialog(
          title: 'Kan ikke genbestille',
          content: Text('Elementer i din ordre er blevet ændret i menuer og kan derfor ikke genbestilles.'),
          cancelText: 'cancelText',
          myOnPressed: () {},
          infoDialog: true,
        );
      },
    );
  }

  TextStyle totalpriceStyle() {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  Widget waitingForResponse() {
    return Card(
      // width: double.infinity,
      color: Colors.orange,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
          child: Column(children: [
            Icon(
              Icons.watch_later_outlined,
              color: Colors.white,
              size: 80,
            ),
            // Icon(
            //   Icons.check_circle_outline_rounded,
            //   color: Colors.white,
            //   size: 80,
            // ),
            Text(
              'Venter',
              style: whiteText.copyWith(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text('Din bestilling er gennemført og venter på svar fra restauranten.\nBestilt kl. ${widget.dateString}',
                style: whiteText, textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: LoadingCircle(
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget orderConfirmed() {
    List<String> acceptTimeString = _calculateValues.dateStringFromMili(widget.order.acceptTime).split(' ');
    // acceptTimeString.forEach((element) {print(element);});
    return Card(
      // width: double.infinity,
      color: Colors.green,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
          child: Column(children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 80,
            ),
            Text(
              'Accepteret',
              style: whiteText.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // Text('Bestilt kl. ${widget.dateString}', style: whiteText, textAlign: TextAlign.center),
            Text('Din ordre er blevet accepteret\nog kan afhentes kl.', style: whiteText, textAlign: TextAlign.center),
            Text(
              acceptTimeString[0],
              style: whiteText.copyWith(fontWeight: FontWeight.w300, fontSize: 40),
            ),
            Text(
              acceptTimeString[2],
              style: whiteText.copyWith(fontWeight: FontWeight.w200, fontSize: 18, height: 0.8),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Restaurant besked:\n${widget.order.restaurantMessage}',
                style: whiteText,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget orderDeclined() {
    return Card(
      // width: double.infinity,
      color: Colors.red[400],
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
          child: Column(children: [
            Icon(
              Icons.cancel_rounded,
              color: Colors.white,
              size: 80,
            ),
            Text(
              'Afvist',
              style: whiteText.copyWith(fontSize: 50, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Din ordre blev afvist.\n Besked fra restauranten:\n${widget.order.restaurantMessage}',
              style: whiteText,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Du kan ringe til restauranten på:\n${F.companyPhone}',
                style: whiteText,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  bool checkIfCanReorder() {
    List<List<MenuItem>> allMenuItems = F.allMenus;

    int foundIndex = -1;

    widget.order.menuOrder.forEach((orderElement) {
      for (var allMenuElement in allMenuItems) {
        foundIndex = allMenuElement.indexWhere((element) => element.id == orderElement.id);
        print('foundindex: $foundIndex');
        if (foundIndex != -1) {
          if (allMenuElement[foundIndex] != orderElement) {
            throw 'MenuItems does not match.';
          }

          for (var i = 0; i < allMenuElement[foundIndex].meatChoice.length - 1; i++) {
            if (orderElement.meatChoice[i] != allMenuElement[foundIndex].meatChoice[i]) {
              throw 'MeatChoice does not match.';
            }
          }
        }
        if (foundIndex != -1) break;
      }
    });
    return true;
  }
}

class OrderItemListTile extends StatelessWidget {
  final MenuItem menuItem;
  const OrderItemListTile(this.menuItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(menuItem.id.toString()),
      title: Text(menuItem.title),
      trailing: Text(menuItem.amount.toString() + 'x'),
    );
  }
}
