import 'package:flutter/material.dart';
import '../../model/MealsLog.dart';

import 'BottomCart.dart';
import 'MenuAndCategories.dart';

class MenuPage extends StatefulWidget {
  final ValueChanged<int> notifyParent;

  const MenuPage({required this.notifyParent});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: MenuAndCategories(updateNewTotal: _updateNewTotal, totalCartPrice: MealsLog.totalPrice)),
        BottomCart(
          sum: MealsLog.totalPrice,
          myOnPressed: () => _refreshParent(1),
        ),
      ],
    );
  }

  _refreshParent(int index) {
    widget.notifyParent(index);
  }

  _updateNewTotal(int changedValue) {
    setState(() {
      MealsLog.totalPrice += changedValue;
    });
  }
}
