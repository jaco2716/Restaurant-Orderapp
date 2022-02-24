import 'package:flutter/material.dart';
import 'package:restaurantorderapp/Logic/MenuLogic.dart';

import '../../flavors.dart';
import 'AddAndRemoveButton.dart';

class MenuElementListTile extends StatelessWidget {
  final dynamic element;
  final ValueChanged<int> updateNewTotal;
  final void Function(void Function()) setModalState;

  MenuElementListTile({
    required this.element,
    required this.updateNewTotal,
    required this.setModalState,
  });

  final MenuLogic _menuLogic = MenuLogic();

  @override
  Widget build(BuildContext context) {
    String? description;
    try {
      description = element.description;
    } catch (e) {
      description = null;
    }
    return Row(
      children: [
        Expanded(
          child: ListTile(
            // contentPadding: EdgeInsets.all(10),
            // dense: true,
            title: Text(element.title),
            subtitle: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description != null ? Text(description) : Center(),
                  Text(
                    element.price.toString() + 'kr,-',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            isThreeLine: true,
          ),
        ),
        element.amount != 0
            ? Card(
                color: F.appSecondaryColor[900],
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Text(
                    '${element.amount.toString()}x',
                    style: TextStyle(color: Colors.white),
                  ),
                )))
            : Center(),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            height: 100,
            width: 55,
            child: Column(
              children: <Widget>[
                AddAndRemoveButton(
                    amount: element.amount,
                    icon: Icon(Icons.remove),
                    color: Colors.red,
                    myOnPressed: () {
                      setModalState(() {
                        int value = _menuLogic.changeAmount(element, -1);
                        updateNewTotal(value);
                      });
                    }),
                AddAndRemoveButton(
                    amount: element.amount,
                    icon: Icon(Icons.add),
                    color: Colors.green,
                    myOnPressed: () {
                      setModalState(() {
                        print('hejsa');
                        int value = _menuLogic.changeAmount(element, 1);
                        updateNewTotal(value);
                      });
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
