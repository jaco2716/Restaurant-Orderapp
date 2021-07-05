import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'flavors.dart';
import 'model/MealsLog.dart';
import 'my_app.dart';

Future<void> main() async {
  F.appFlavor = Flavor.orderappTest;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MealsLog.allMenus = F.allMenus;
  MealsLog.menuCategoryCards = F.menuCategoryCards;
  //sadoasdo
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}
