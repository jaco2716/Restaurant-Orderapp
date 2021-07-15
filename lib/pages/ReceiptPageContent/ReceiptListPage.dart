// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurantorderapp/MyWidgets/LoadingCircle.dart';
import 'package:restaurantorderapp/flavors.dart';
import '../../model/MenuItem.dart';
import '../../model/Order.dart';
import '../../model/OrderUser.dart';
import 'ReceiptListRow.dart';

class ReceiptListPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User currentUser;
  ReceiptListPage(this.currentUser);

  @override
  Widget build(BuildContext context) {
    // print('${currentUser.toString()}');
    // List<MenuItem> menuItems = [
    //   MenuItem(
    //     30,
    //     'MARGHERITA',
    //     'Tomat og ost',
    //     65,
    //     'assets/menu/temp.png',
    //     1, meatChoice: [],
    //   ),
    //   MenuItem(
    //     31,
    //     'CAPRICCIOSA',
    //     'Skinke og champignon',
    //     75,
    //     'assets/menu/temp.png',
    //     1, meatChoice: [],
    //   ),
    //   MenuItem(
    //     32,
    //     'CACCIATORE',
    //     'Pepperoni, oliven og friske tomater',
    //     75,
    //     'assets/menu/temp.png',
    //     2, meatChoice: [],
    //   ),
    //   MenuItem(
    //     33,
    //     'CALZONE (INDBAGT)',
    //     'Med skinke og champignon',
    //     75,
    //     'assets/menu/temp.png',
    //     1, meatChoice: [],
    //   ),
    //   MenuItem(
    //     34,
    //     'HAWAII',
    //     'Skinke og ananas',
    //     75,
    //     'assets/menu/temp.png',
    //     2, meatChoice: [],
    //   ),
    // ];
    // OrderUser user = OrderUser(email: 'email.demo@gamil.com', fullName: 'Fornavn Efternavn', phoneNr: '+45 12 34 56 78', uid: "123321");
    // List<Order> orders = [
    //   Order(
    //       acceptTime: '1621241246122',
    //       menuOrder: menuItems,
    //       orderAccepted: true,
    //       orderDate: '1621241242122',
    //       orderDone: true,
    //       orderMessage: 'Ingen besked.',
    //       restaurantMessage: 'Ingen besked fra restauranten.',
    //       user: user),
    //   Order(
    //       acceptTime: '1621241276122',
    //       menuOrder: menuItems,
    //       orderAccepted: false,
    //       orderDate: '1621241242122',
    //       orderDone: true,
    //       orderMessage: 'Ingen besked.',
    //       restaurantMessage: 'Ingen besked fra restauranten.',
    //       user: user),
    //   Order(
    //       acceptTime: '1621241396122',
    //       menuOrder: menuItems,
    //       orderAccepted: false,
    //       orderDate: '1621241242122',
    //       orderDone: false,
    //       orderMessage: 'Ingen besked.',
    //       restaurantMessage: 'Ingen besked fra restauranten.',
    //       user: user),
    // ];

    return Column(
      children: [
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: orders.length,
        //     itemBuilder: (_, int index) {
        //       print('object');
        //       return ReceiptListRow(currentUser, orders[index]);
        //     },
        //   ),
        // ),

        StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('${F.firestoreCollection}/orders')
                .where('user.uid', isEqualTo: currentUser.uid)
                // .orderBy('orderDate', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Expanded(child: Center(child: Text("Du har ingen ordrer endnu.")));
              // else if (snapshot.hasError) return Expanded(child: Center(child: Text('Error: ${snapshot.error}')));
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Expanded(child: Center(child: LoadingCircle()));
                default:
                  List<Order> orders = [];
                  // Map to list instead
                  snapshot.data?.docs.forEach((e) {
                    Order dataOrder = Order.fromJson(e.data() as Map<String, dynamic>);
                    orders.add(dataOrder);
                    print(dataOrder.toJson());
                  });
                  final int dataCount = orders.length;
                  if (dataCount == 0)
                    return Expanded(
                      child: Center(child: Text("Du har ingen tidligere ordre")),
                    );
                  else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: dataCount,
                        itemBuilder: (_, int index) {
                          return ReceiptListRow(currentUser, orders[index]);
                        },
                      ),
                    );
                  }
              }
            }),
      ],
    );
  }
}
