import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../flavors.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;
  MyAppBar(this._title);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      // brightness: Brightness.dark,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: F.appPrimaryColor[700],
      title: Text(_title),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(F.appIconPathLight),
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
