import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../flavors.dart';

class MyIconGridButton extends StatelessWidget {
  String title;
  String url;
  Icon icon;
  String? subtitle;
  bool canTap;
  Widget? trailing;

  MyIconGridButton({
    required this.title,
    required this.url,
    required this.icon,
    this.subtitle,
    this.canTap = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onSurface: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(5),
        ),
        onPressed: canTap
            ? () async {
                bool canLaunch = await urlLauncher.canLaunch(url);
                if (canLaunch) {
                  await urlLauncher.launch(url);
                }
              }
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 50,
              width: 50,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: F.appSecondaryColor[900],
                child: icon,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(text: title),
                      subtitle != null
                          ? TextSpan(
                              text: '\n$subtitle',
                              style: TextStyle(color: Colors.black87, fontSize: 8, fontWeight: FontWeight.w300),
                            )
                          : TextSpan(),
                    ],
                  ),
                ),
              ),
            ),
            trailing == null ? Center() : trailing!,
          ],
        ));
  }
}