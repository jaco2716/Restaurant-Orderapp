import 'package:flutter/material.dart';
import 'package:restaurantorderapp/model/MeatChoice.dart';
import 'package:restaurantorderapp/model/MenuItem.dart';

import 'MenuElementListTile.dart';

class MyModalMeatChoice extends StatefulWidget {
  final List<MeatChoice> meatChoices;
  final MenuItem menuItem;
  final int totalPrice;
  final ValueChanged<int> notifyParent;
  
  MyModalMeatChoice({
    required this.meatChoices,
    required this.menuItem,
    required this.totalPrice,
    required this.notifyParent,
  });

  @override
  _MyModalMeatChoiceState createState() => _MyModalMeatChoiceState();
}

class _MyModalMeatChoiceState extends State<MyModalMeatChoice> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        children: [
          Card(
            color: Colors.grey[300],
            child: SizedBox(
              width: 100,
              height: 5,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${widget.menuItem.title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text('Tilføj ekstra tilbehør.'),
          ),
          Divider(
            height: 1,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 180,
            child: Stack(children: [
              ListView.separated(
                itemCount: widget.meatChoices.length,
                padding: EdgeInsets.only(bottom: 80),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return MenuElementListTile(element: widget.meatChoices[index], notifyParent: widget.notifyParent, totalPrice: widget.totalPrice, setModalState: setState);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 1,
                  );
                },
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   padding: EdgeInsets.all(15)
                        // ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Færdig')),
                  ))
            ]),
          ),
        ],
      ),
    );
  }
}
