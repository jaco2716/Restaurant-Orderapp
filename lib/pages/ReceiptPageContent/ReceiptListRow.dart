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
    // String orderPrice = _calculateValues.totalPriceFromOrder(order.menuOrder).toString();
    if (order.orderAccepted){
      acceptTimeString = _calculateValues.dateStringFromMili(order.acceptTime);
      orderIcon = Icon(Icons.check_circle, size: 35, color: Colors.green,);
    } else if (order.orderDone) {
      orderIcon = Icon(Icons.cancel, size: 35, color: Colors.red,);
      acceptTimeString = 'Ordre afvist';
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        elevation: 5,
      child: InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ListTile(
              minLeadingWidth: 35,
              horizontalTitleGap: 5,
              leading: Icon(Icons.receipt),
              title: Text('Ordre nr: ${order.orderDate}'),
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
    );
  }
}
