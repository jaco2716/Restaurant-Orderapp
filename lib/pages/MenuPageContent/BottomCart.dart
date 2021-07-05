import 'package:flutter/material.dart';

class BottomCart extends StatelessWidget {
  final int sum;
  // final ValueChanged<int> notifyParent;
  final void Function() myOnPressed;

  const BottomCart({
    required this.sum,
    required this.myOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.red[600],
        height: 70,
        width: double.infinity,
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: ListTile(
            leading: Icon(
              Icons.shopping_basket,
              size: 40,
            ),
            title: Text('Total: ${sum != null ? sum.toString() : '0'}kr,-'),
            subtitle: Text('Gå til kurv'),
            onTap: () => myOnPressed(),
          ),
        ),
      ),
    );
  }
}
