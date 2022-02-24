import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurantorderapp/flavors.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options_ilmolino.dart';
import 'model/MealsLog.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  F.appFlavor = Flavor.ilmolino;
  MealsLog.allMenus = F.allMenus;
  MealsLog.menuCategoryCards = F.menuCategoryCards;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    print('############### - Main ilmolino - #################');
    print('############### - Main ilmolino - #################');
    runApp(MyApp());
  });
}
//Run in release mode:
//flutter run --release --flavor ilmolino -t lib/main_ilmolino.dart
