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
        Expanded(child: MenuAndCategories(notifyParent: _refresh, totalCartPrice: MealsLog.totalPrice)),
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

  _refresh(int total) {
    setState(() {
      MealsLog.totalPrice = total;
    });
  }
}
