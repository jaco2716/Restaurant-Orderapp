import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurantorderapp/flavors.dart';
import 'package:firebase_core/firebase_core.dart';


import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  F.appFlavor = Flavor.ilmolino;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}
