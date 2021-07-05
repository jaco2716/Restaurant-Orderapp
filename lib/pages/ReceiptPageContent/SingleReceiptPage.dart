// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/model/MenuItem.dart';
import 'package:restaurantorderapp/model/Order.dart';
import '../../flavors.dart';
import '../my_home_page.dart';
import '/Pages/OrderPageContent/OrderConfirmation.dart';
import '/../MyWidgets/LoadingCircle.dart';
import '/../MyWidgets/MyAppBar.dart';
import '/../CalculateValues.dart';
// import '../../Login/LoadingCircle.dart';
// import '../../LoginPageProvider.dart';

// import '../../OrderPageContent/OrderConfirmation.dart';


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
  // Firestore _firestore = Firestore.instance;
  // DocumentReference docRef;
  bool showOrderAgain = false;
  bool hasRefreshed = false;

  @override
  Widget build(BuildContext context) {
    // docRef = _firestore.collection('orders').document(widget.order.orderDate);

    return Scaffold(
      appBar: !widget.fromMakeOrder
          ? MyAppBar('Nr: ${widget.order.orderDate}')
          : AppBar(
              backgroundColor: Colors.green[900],
              title: Text('Nr: ${widget.order.orderDate}'),
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (Route<dynamic> route) => false);
                },
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.order.orderAccepted
                  ? orderConfirmed()
                  : widget.order.orderDone
                      ? orderDeclined()
                      : waitingForResponse(),
              // StreamBuilder<DocumentSnapshot>(
              //   stream: docRef.snapshots(),
              //   builder: (BuildContext streamContext,
              //       AsyncSnapshot<DocumentSnapshot> snapshot) {
              //     if (!snapshot.hasData)
              //       return Container(height: 88, child: LoadingCircle());
              //     else if (snapshot.hasError)
              //       return Center(child: Text('Error: ${snapshot.error}'));
              //     else {
              //       Order orderStream = Order.fromJson(snapshot.data.data);
              //       Future.delayed(Duration.zero, () {
              //         if (orderStream.orderAccepted && !showOrderAgain) {
              //           setState(() {
              //             showOrderAgain = true;
              //             print('update!!');
              //             widget.order.restaurantMessage =
              //                 orderStream.restaurantMessage;
              //             widget.order.acceptTime = orderStream.acceptTime;
              //           });
              //         }
              //         if (orderStream.orderDone && !hasRefreshed) {
              //           setState(() {
              //             hasRefreshed = true;
              //             print('update!!');
              //             widget.order.restaurantMessage =
              //                 orderStream.restaurantMessage;
              //           });
              //         }
              //       });
              //       return orderStream.orderAccepted
              //           ? orderConfirmed()
              //           : orderStream.orderDone
              //               ? orderDeclined()
              //               : waitingForResponse();
              //     }
              //   },
              // ),

              //Text(widget.order.orderDate),
              // widget.order.orderAccepted
              //     ? orderConfirmed()
              //     : widget.order.orderDone
              //         ? orderDeclined()
              //         : waitingForResponse(),
              Card(
                elevation: 5,
                child: ListTile(
                  title: Text('Navn: ${widget.order.user.fullName}'),
                  subtitle: Text('Tlf: ${widget.order.user.phoneNr} \nE-mail: ${widget.order.user.email}'),
                ),
              ),
              Divider(),
              Text('Bestilt ${widget.dateString}'),
              OrderConfirmation(widget.order.menuOrder),
              SizedBox(
                height: 15,
              ),
              showOrderAgain
                  ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4),
                      height: 60,
                      child: RaisedButton(
                          child: Text('Bestil igen!'),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => loginNextPage(widget.order.menuOrder, 'OrderPage')));
                          }),
                    )
                  : Center(),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle totalpriceStyle() {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  Widget waitingForResponse() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        Text(
          'Venter',
          style: TextStyle(fontSize: 50, color: Colors.yellow[700], fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text('Venter på svar fra restauranten.'),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: LoadingCircle(),
        )
      ]),
    );
  }

  Widget orderConfirmed() {
    List<String> acceptTimeString = CalculateValues.dateStringFromMili(widget.order.acceptTime).split(' ');
    // acceptTimeString.forEach((element) {print(element);});
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        Text(
          'Accepteret',
          style: TextStyle(fontSize: 40, color: Colors.green[600], fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text('Hent din ordre kl.'),
        Text(
          acceptTimeString[0],
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 40),
        ),
        Text(
          acceptTimeString[2],
          style: TextStyle(fontWeight: FontWeight.w100, fontSize: 20),
        ),
        Text(
          'Restaurant besked:\n${widget.order.restaurantMessage}',
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }

  Widget orderDeclined() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        Text(
          'Afvist',
          style: TextStyle(fontSize: 50, color: Colors.red[600], fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          'Restaurant besked:\n${widget.order.restaurantMessage}',
          textAlign: TextAlign.center,
        ),
        Text(
          'Du kan ringe til restauranten på ${F.companyPhone}',
          textAlign: TextAlign.center,
        ),
      ]),
    );
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
