import 'package:flutter/material.dart';

class MyRoundedButton extends StatelessWidget {
  final String title;
  final void Function() myOnPressed;
  MyRoundedButton({
    required this.title,
    required this.myOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 90, vertical: 7),
      width: double.infinity,
      height: 73,
      child: ElevatedButton(
        onPressed: () => myOnPressed(),
        child: Text(title),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
