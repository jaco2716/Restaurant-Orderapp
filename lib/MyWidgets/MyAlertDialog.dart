import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String cancelText;
  final void Function() myOnPressed;
  final String confirmText;
  final Color confirmColor;
  final bool infoDialog;

  MyAlertDialog({
    required this.title,
    required this.content,
    required this.cancelText,
    required this.myOnPressed,
    this.confirmText = '',
    this.confirmColor = Colors.blue,
    this.infoDialog = false,
  });
  
  final TextStyle _titleText = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
      actionsPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.only(top: 10, bottom: 0, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Container(
        child: Text(
          title,
          style: _titleText,
          textAlign: TextAlign.center,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: content,
      ),
      actions: [
        Container(

          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: infoDialog ? Colors.blue : Colors.grey,
                      padding: EdgeInsets.all(12),
                    ),
                    child: Text(
                      cancelText,
                      // style: _whiteText,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              infoDialog
                  ? Center()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: confirmColor,
                            padding: EdgeInsets.all(12),
                          ),
                          child: Text(
                            confirmText,
                            // style: _whiteText,
                          ),
                          onPressed: () => myOnPressed(),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
