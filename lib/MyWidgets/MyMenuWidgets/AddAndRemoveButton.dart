import 'package:flutter/material.dart';

class AddAndRemoveButton extends StatelessWidget {
  int amount;
  Icon icon;
  Color color;
  void Function() myOnPressed;
  bool sideways;

  AddAndRemoveButton({
    required this.amount,
    required this.icon,
    required this.color,
    required this.myOnPressed,
    this.sideways = false,
  });

  @override
  Widget build(BuildContext context) {
    double bottomRadius = color == Colors.red ? 0 : 10;
    double topRadius = color != Colors.red ? 0 : 10;
    return Container(
      // color: amount > 0 && color == Colors.red ? Colors.grey : color,
      // width: 60,
      height: 40,
      child: Card(
        margin: EdgeInsets.all(2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(sideways ? bottomRadius : topRadius),
          bottomLeft: Radius.circular(sideways ? topRadius : bottomRadius),
          bottomRight: Radius.circular(bottomRadius),
        )),
        color: amount <= 0 && color == Colors.red ? Colors.grey : color,
        child: IconButton(
          onPressed: () => myOnPressed(),
          icon: icon,
          iconSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
