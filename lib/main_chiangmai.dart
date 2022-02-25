// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'flavors.dart';
// import 'model/MealsLog.dart';
// import 'my_app.dart';

// Future<void> main() async {
//   F.appFlavor = Flavor.orderappTest;
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   MealsLog.allMenus = F.allMenus;
//   MealsLog.menuCategoryCards = F.menuCategoryCards;
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
//     print('############### - Main chiangmai - #################');
//     runApp(MyApp());
//   });
// }

// //Run 
// //flutter run --flavor orderapptest -t lib/main_orderapptest.dart
// //Run in release mode:
// //flutter run --release --flavor orderapptest -t lib/main_orderapptest.dart
