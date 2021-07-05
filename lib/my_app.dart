import 'package:flutter/material.dart';
import 'pages/my_home_page.dart';

class MyApp extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrderApp template',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        buttonTheme: ButtonThemeData(buttonColor: Colors.green[600], textTheme: ButtonTextTheme.primary),
      ),
      home: MyHomePage(),
    );
  }
}
