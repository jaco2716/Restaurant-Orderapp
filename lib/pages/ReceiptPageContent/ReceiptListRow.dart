// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Logic/CalculateValues.dart';
import '../../model/Order.dart';
import 'SingleReceiptPage.dart';

class ReceiptListRow extends StatelessWidget {
  //final Firestore _firestore = Firestore.instance;
  final Order order;
  // final FirebaseUser currentUser;
  final dynamic currentUser;
  ReceiptListRow(this.currentUser, this.order);
  final CalculateValues _calculateValues = CalculateValues();


  @override
  Widget build(BuildContext context) {
    String orderDateString =
        _calculateValues.dateStringFromMili(order.orderDate);
    Icon orderIcon = Icon(Icons.watch_later, size: 35, color: Colors.grey,);
    String acceptTimeString = 'Venter...';
    if (order.orderAccepted){
      acceptTimeString = _calculateValues.dateStringFromMili(order.acceptTime);
      orderIcon = Icon(Icons.check_circle, size: 35, color: Colors.green,);
    } else if (order.orderDone) {
      orderIcon = Icon(Icons.cancel, size: 35, color: Colors.red,);
      acceptTimeString = 'Ordre afvist';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Card(
        elevation: 5,
        child: InkWell(
          child: Container(
              padding: EdgeInsets.all(20),
              child: ListTile(
                title: Text('Ordre nr: '+order.orderDate),
                subtitle: Text('Bestilt · $orderDateString \nAfhent · $acceptTimeString'),
                trailing: orderIcon,
              )
              ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SingleReceiptPage(order, orderDateString, false)));
          },
        ),
      ),
    );
  }
}
