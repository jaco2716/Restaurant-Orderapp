import 'package:flutter/material.dart';
import 'package:restaurantorderapp/MyWidgets/MyMenuWidgets/AddAndRemoveButton.dart';
import 'package:restaurantorderapp/flavors.dart';
import 'package:restaurantorderapp/model/MealsLog.dart';
import 'package:restaurantorderapp/model/MeatChoice.dart';
import 'package:restaurantorderapp/model/MenuItem.dart';

import 'MenuElementListTile.dart';

class MyModalMeatChoice extends StatefulWidget {
  final List<MeatChoice> meatChoices;
  final MenuItem menuItem;
  final ValueChanged<int> updateNewTotal;
  final bool cartPageModal;

  MyModalMeatChoice({
    required this.meatChoices,
    required this.menuItem,
    required this.updateNewTotal,
    this.cartPageModal = false,
  });

  @override
  _MyModalMeatChoiceState createState() => _MyModalMeatChoiceState();
}

class _MyModalMeatChoiceState extends State<MyModalMeatChoice> {
  double downsize = 100;
  // double meatChoiceSize = 500;
  @override
  Widget build(BuildContext context) {
    downsize = widget.cartPageModal && widget.meatChoices.length == 0 ? 400 : 100;
    // meatChoiceSize = widget.cartPageModal ? 400 : ;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                )
              ],
              color: Colors.white,
            ),
            child: Column(children: [
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
              widget.meatChoices.length != 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text('Tilføj ekstra tilbehør.'),
                    )
                  : SizedBox(
                      height: 15,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AddAndRemoveButton(
                    amount: widget.menuItem.amount - 1,
                    icon: Icon(Icons.remove),
                    color: Colors.red,
                    myOnPressed: () {
                      if (widget.menuItem.amount > 1) {
                        widget.menuItem.amount--;
                        setState(() {
                          MealsLog.allMenus.forEach((element) {
                            updateOrder(element, widget.menuItem, widget.menuItem.amount);
                          });
                        });
                        widget.updateNewTotal(0);
                      }
                    },
                    sideways: true,
                  ),
                  Card(
                      margin: EdgeInsets.zero,
                      color: F.appSecondaryColor[900],
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: EdgeInsets.all(12),
                        child: FittedBox(
                          // fit: BoxFit.,
                          child: Text(
                            '${widget.menuItem.amount.toString()}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  // Card(
                  //   color: F.appSecondaryColor[900],
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(1.0),
                  //     child: Text(widget.menuItem.amount.toString(), style: TextStyle(color: Colors.white, fontSize: 20),),
                  //     // child: Text(itemAmount.toString(), textScaleFactor: 3),
                  //   ),
                  // ),
                  AddAndRemoveButton(
                    amount: widget.menuItem.amount,
                    icon: Icon(Icons.add),
                    color: Colors.green,
                    myOnPressed: () {
                      widget.menuItem.amount++;
                      setState(() {
                        MealsLog.allMenus.forEach((element) {
                          updateOrder(element, widget.menuItem, widget.menuItem.amount);
                        });
                      });
                      widget.updateNewTotal(0);
                    },
                    sideways: true,
                  ),
                ],
              ),
              TextButton(
                child: Text(
                  'Fjern fra ordre',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  MealsLog.allMenus.forEach((element) {
                    updateOrder(element, widget.menuItem, 0);
                  });
                  widget.updateNewTotal(0);

                  Navigator.pop(context);
                },
              ),
            ]),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 284,
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              widget.meatChoices.length != 0
                  ? Expanded(
                      // height: meatChoiceSize,
                      child: ListView.separated(
                        itemCount: widget.meatChoices.length,
                        // padding: EdgeInsets.only(bottom: 80),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return MenuElementListTile(
                              element: widget.meatChoices[index], updateNewTotal: widget.updateNewTotal, setModalState: setState);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                          );
                        },
                      ),
                    )
                  : Center(),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black12,
                    )
                  ],
                  color: Colors.white,
                ),
                child: _doneButton(),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget _doneButton() {
    return Align(
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
        ));
  }

  void updateOrder(List<MenuItem> menuItems, MenuItem newItem, int newAmount) {
    menuItems.forEach((element) {
      if (element.id == newItem.id) {
        element.amount = newAmount;
        if (newAmount == 0 && element.meatChoice.length != 0) {
          element.meatChoice.forEach((element) => element.amount = 0);
        }
      }
    });
  }
}
