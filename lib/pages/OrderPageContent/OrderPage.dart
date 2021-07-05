// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:il_molino_orderapp/AppBarLeo.dart';
// import 'package:il_molino_orderapp/Login/AuthService.dart';
// import 'package:il_molino_orderapp/Login/LoadingCircle.dart';
// import 'package:il_molino_orderapp/Login/LoginPage.dart';
// import 'package:il_molino_orderapp/Model/User.dart';
// import 'package:il_molino_orderapp/OrderPageContent/OrderConfirmation.dart';
// import 'package:il_molino_orderapp/Retrofit/ApiValues.dart';
// import 'package:provider/provider.dart';

// import '../Model/MenuItem.dart';

// class OrderPage extends StatelessWidget {
//   final Firestore _firestore = Firestore.instance;
//   final List<MenuItem> cartItems;
//   FirebaseUser currentUser;
//   OrderPage(this.cartItems, this.currentUser);
//   User user = User();

//   String serverToken =
//       'AAAALduRePU:APA91bHXoPXMG7XmhwiPfl1GxuSyn5ds47H_sbNVbk9RZQv0F4c9OY4Xa9w8HtMgpRszJk2i5qSCVz2deJJ0zDI72Y3SP-r7uczK4L3R0YxF1TEuQCqKGAt4PTv-s3tL9q-sqdTbMMvd';

//   @override
//   Widget build(BuildContext context) {
//     var docRef = _firestore.collection('users').document(currentUser.uid);
//     return Scaffold(
//       appBar: AppBarLeo('Bestilling'),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: RaisedButton(
//                     child: Text('Log out'),
//                     color: Colors.red,
//                     onPressed: () async {
//                       //Navigator.pop(context);
//                       await Provider.of<AuthService>(context, listen: false)
//                           .logout();
//                     }),
//               ),
//               TextField(),
//               StreamBuilder<DocumentSnapshot>(
//                 stream: docRef.get().asStream(),
//                 builder: (BuildContext streamContext,
//                     AsyncSnapshot<DocumentSnapshot> snapshot) {
//                   if (!snapshot.hasData)
//                     return LoadingCircle();
//                   else if (snapshot.hasError)
//                     return Text('Error: ${snapshot.error}');
//                   else {
//                     user = User.fromJson(snapshot.data.data);

//                     return ListTile(
//                       title: Text(user.fullName),
//                       subtitle: Text(user.phoneNr + '\n' + user.email),
//                       isThreeLine: true,
//                       trailing: SizedBox(
//                         width: 60,
//                         height: 50,
//                         child: RaisedButton(
//                           padding: EdgeInsets.all(10),
                          
//                     child: Text('Log out', textAlign: TextAlign.center),
//                     color: Colors.red,
//                     onPressed: () async {
//                         //Navigator.pop(context);
//                         await Provider.of<AuthService>(context, listen: false)
//                             .logout();
//                     }),
//                       ),
//                     );
//                   }
//                 },
//               ),
//               OrderConfirmation(cartItems),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   width: double.infinity,
//                   height: 50,
//                   child: RaisedButton(
//                       onPressed: () {
//                         _buildErrorDialog(context, 'Please wait',
//                             'Waiting for response from restaurant.');
//                         confirmOrder();
//                       },
//                       child: Text('Bekræft')),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future _buildErrorDialog(
//       BuildContext context, String _title, String _message) {
//     return showDialog(
//       builder: (context) {
//         return AlertDialog(
//           title: Text(_title),
//           content: SizedBox(
//               height: 130,
//               child: Column(children: [
//                 Text(_message),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 40.0),
//                   child: LoadingCircle(),
//                 )
//               ])),
//           actions: <Widget>[
//             FlatButton(
//                 child: Text('Close'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 })
//           ],
//         );
//       },
//       context: context,
//     );
//   }

//   void confirmOrder() {
//     List<Map<String, dynamic>> finalItems = List<Map<String, dynamic>>();
//     cartItems.forEach((element) {
//       finalItems.add(element.toJson());
//     });
//     String orderDate = DateTime.now().millisecondsSinceEpoch.toString();
//     //_postToFcm();
//     postToFireStore(finalItems, orderDate);
//     sendAndRetrieveMessage(finalItems, orderDate);
//   }

//   void sendAndRetrieveMessage(
//       List<Map<String, dynamic>> finalItems, String orderDate) async {
//     await post(
//       ApiValues.baseURL + '/fcm/send',
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=${ApiValues.serverToken}',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': 'New Order!',
//             'title': 'Order From Jacob',
//             'sound': 'default',
//             'badge': '1',
//           },
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'id': orderDate,
//             'status': 'done'
//           },
//           'to':
//               'fVxy9YdwLkkYs4dCn2pNzq:APA91bEguTcHYESs03OOyymoo9fpcut72mJGtQOailIG_Ft0wYW1QzhWB_OwpeL0pprty2F7LB0Vyz3GzxU5QbFvh04OoEhQ5n5biSyHLAS93P_10sEnCcHYwIqrDBcO4w908qdp41id',
//         },
//       ),
//     )
//         .then((value) => print('notification sucess'))
//         .catchError((error) => print(error));
//   }

//   Future<void> postToFireStore(
//       List<Map<String, dynamic>> finalItems, String orderDate) async {
//     //print('Sending to db');

//     var docpostRef = _firestore.collection('orders');

//     await docpostRef.document(orderDate).setData({
//       'menuOrder': finalItems,
//       'user': user.toJson(),
//       'orderDate': orderDate,
//       'orderDone': false,
//       'orderAccepted': false,
//       'acceptTime': '0',
//       'message': 'No message.',
//     }).then((value) {
//       print('db: success!');
//     }).catchError((onError) {
//       print('db error: ' + onError.toString());
//     });
//   }
// }