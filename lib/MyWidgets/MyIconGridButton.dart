import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../flavors.dart';

class MyIconGridButton extends StatelessWidget {
  final String title;
  final String url;
  final Icon icon;
  final String? subtitle;
  final bool canTap;
  final Widget? trailing;

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
                String finalUrl;
                finalUrl = url.replaceAll('æ', 'ae');
                finalUrl = finalUrl.replaceAll('ø', 'oe');
                finalUrl = finalUrl.replaceAll('å', 'aa');

                if (await urlLauncher.canLaunch(finalUrl)) {
                  await urlLauncher.launch(finalUrl, forceSafariVC: false, forceWebView: false);
                } else {
                  print('### Failed to launch url');
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
                color: F.appColors[1],
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
