import 'package:flutter/material.dart';
import 'package:restaurantorderapp/Logic/CalculateValues.dart';
import 'package:restaurantorderapp/model/NextPageEnum.dart';
import 'package:restaurantorderapp/pages/LoginPageContent/CheckLoginPage.dart';
import '../../flavors.dart';
import '../../model/MealsLog.dart';
import '../../model/MenuItem.dart';

class CartPage extends StatefulWidget {
  final ValueChanged<int> notifyParent;

  const CartPage({required this.notifyParent});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<MenuItem> cartItems = [];
  TextStyle subtitleTextStyle = TextStyle(fontSize: 11, color: Colors.grey[600]);

  @override
  Widget build(BuildContext context) {
    cartItems.clear();
    MealsLog.allMenus.forEach((element) {
      addToCart(element);
    });

    int subtotal = 0;
    cartItems.forEach((element) {
      int meatChoiceTotal = 0;
      // int meatTotalAmount = 0;
      if (element.meatChoice.length != 0) {
        element.meatChoice.forEach((meat) {
          // meatTotalAmount += meat.amount;
          meatChoiceTotal += meat.price * meat.amount;
        });
        // if (element.amount < meatTotalAmount) {
        //   element.meatChoice.forEach((meat2) => meat2.amount = 0);
        //   meatChoiceTotal = 0;
        // }
      }
      subtotal += element.price * element.amount + meatChoiceTotal;
    });
    MealsLog.totalPrice = subtotal;

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(child: cartItems.length > 0 ? buildCart(cartItems) : emptyCart()),
        ),
        Divider(
          height: 1,
          thickness: 2,
        ),
        // ListTile(
        //   title: Text('Total'),
        //   trailing: Text(subtotal.toString() + ' kr,-'),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(subtotal.toString() + ' kr,-'),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
              onPressed: cartItems.isEmpty
                  ? null
                  : () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckLoginPage(NextPage.OrderPage, 'OrderPage', cartItems)));
                    },
              child: Text('Gå til bestilling')),
        )
      ],
    );
  }

  Widget emptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.shopping_basket,
          color: Colors.grey[300],
          size: 150,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Din kurv er tom'),
        ),
      ],
    );
  }

  void addToCart(List<MenuItem> menuItems) {
    menuItems.forEach((element) {
      if (element.amount != 0) {
        MenuItem newElement = MenuItem.clone(element);
        // MenuItem newElement = MenuItem(
        //     id: element.id,
        //     title: element.title,
        //     description: element.description,
        //     price: element.price,
        //     image: element.image,
        //     amount: element.amount,
        //     meatChoice: element.meatChoice);
        cartItems.add(newElement);
      }
    });
  }

  Widget buildCart(List<MenuItem> menuItem) {
    return Container(
      child: ListView.separated(
        itemCount: menuItem.length,
        itemBuilder: (BuildContext context, int index) {
          return menuItem[index].amount > 0 ? cartTile(menuItem[index]) : Center();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
          );
        },
      ),
    );
  }

  Widget cartTile(MenuItem menuItem) {
    int totalItemPrice = menuItem.price * menuItem.amount;
    int totalMeatChoiceAmount = 0;
    List<int> totalMeatChoicePrice = [];
    if (menuItem.meatChoice.length != 0) {
      menuItem.meatChoice.forEach((meat) {
        totalMeatChoicePrice.add(meat.price * meat.amount);
        totalMeatChoiceAmount += meat.amount;
      });
    }
    return InkWell(
      onTap: () {
        showCartBottomSheet(context, menuItem);
      },
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Column(children: [
          Container(
            height: 60,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              minLeadingWidth: 43,
              horizontalTitleGap: 10,
              title: Text(
                menuItem.title,
                // style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
              ),
              subtitle: Text(
                menuItem.description,
                style: TextStyle(fontSize: 12),
              ),
              // subtitle: menuItem.meatChoice.length != 0
              //     ? totalMeatChoiceAmount < 1
              //         ? Text('Tryk her for andet kød/vegetar.')
              //         : ListView.builder(
              //             itemCount: menuItem.meatChoice.length,
              //             itemBuilder: (BuildContext context, int meatIndex) {
              //               return menuItem.meatChoice[meatIndex].amount != 0
              //                   ? Container(
              //                       height: 15,
              //                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //                         Text(
              //                           ' - ${menuItem.meatChoice[meatIndex].amount}x ${menuItem.meatChoice[meatIndex].title}',
              //                           style: TextStyle(fontSize: 11),
              //                         ),
              //                         Text(
              //                           '+ ${totalMeatChoicePrice[meatIndex].toString()},00,-',
              //                           style: TextStyle(fontSize: 11),
              //                         ),
              //                       ]),
              //                     )
              //                   : Container();
              //             },
              //             shrinkWrap: true,
              //             physics: NeverScrollableScrollPhysics(),
              //           )
              //     : Text(
              //         menuItem.description,
              //         style: TextStyle(fontSize: 12),
              //       ),
              // leading: Container(
              //   width: 40,
              //   height: 40,
              //   child: Card(
              //       color: Colors.yellow[900],
              //       child: Center(
              //           child: Text(
              //         '${menuItem.amount.toString()}x',
              //         style: TextStyle(color: Colors.white),
              //       ))),
              // ),
              leading: FittedBox(
                child: Card(
                    color: F.appSecondaryColor[900],
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Text(
                        '${menuItem.amount.toString()}x',
                        style: TextStyle(color: Colors.white),
                      ),
                    ))),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //     Container(
                  //   width: 80,
                  //   height: 50,
                  //   child: Card(
                  //       color: Colors.white,
                  //       child: Center(
                  //           child: Text(
                  //         '- ${menuItem.amount.toString()}x +',
                  //         style: TextStyle(color: Colors.black54),
                  //       ))),
                  // ),
                  Container(
                      width: 65,
                      child: Text(
                        totalItemPrice.toString() + ' kr,-',
                        textAlign: TextAlign.end,
                      )),
                ],
              ),
            ),
          ),
          menuItem.meatChoice.length != 0
              ? totalMeatChoiceAmount < 1
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 65, right: 12, bottom: 10),
                        child: Text(
                          '- Tryk for at tilføje ekstra.',
                          style: subtitleTextStyle,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 65, right: 12, bottom: 10),
                      child: ListView.builder(
                        itemCount: menuItem.meatChoice.length,
                        itemBuilder: (BuildContext context, int meatIndex) {
                          return menuItem.meatChoice[meatIndex].amount != 0
                              ? Container(
                                  height: 15,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text(
                                      '+ ${menuItem.meatChoice[meatIndex].amount}x ${menuItem.meatChoice[meatIndex].title}',
                                      style: subtitleTextStyle,
                                    ),
                                    Text(
                                      '${totalMeatChoicePrice[meatIndex].toString()} kr,-',
                                      style: subtitleTextStyle,
                                    ),
                                  ]),
                                )
                              : Container();
                        },
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    )
              : SizedBox(
                  height: 10,
                ),
        ]),
      ),
    );
  }

  showCartBottomSheet(BuildContext context, MenuItem menuItem) {
    int itemAmount = menuItem.amount;
    // List<MeatChoice> modalMeatChoice = new List<MeatChoice>();
    // modalMeatChoice.clear();

    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          // if (menuItem.id > 5 && menuItem.id < 8)
          //   soupMeatChoice.forEach((element) => modalMeatChoice.add(MeatChoice(element.title, element.price, element.value, element.amount)));
          // else if (menuItem.id > 7 && menuItem.id < 11)
          //   noodleAndFriedRiceMeatChoice
          //       .forEach((element) => modalMeatChoice.add(MeatChoice(element.title, element.price, element.value, element.amount)));
          // else if (menuItem.id > 10 && menuItem.id < 21)
          //   mainMealWithRiceMeatChoice
          //       .forEach((element) => modalMeatChoice.add(element));

          //print(modalMeatChoice.length);
          return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
            int totalExtraMeat = 0;
            if (menuItem.meatChoice.length != 0) {
              menuItem.meatChoice.forEach((element) {
                totalExtraMeat += element.amount;
              });
            }
            //print(menuItem.meatChoice.toString());
            // menuItem.meatChoice.forEach((element) {
            //   totalExtraMeat += element.amount;
            // });
            // modalMeatChoice.forEach((element) {
            //   totalExtraMeat += element.amount;
            // });
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Wrap(children: [
                Container(
                  //height: 600,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        menuItem.meatChoice.length == 0
                            ? Center()
                            : Column(children: [
                                Text('Tilføj ekstra tilbehør'),
                                ListView.builder(
                                  itemCount: menuItem.meatChoice.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      height: 40,
                                      width: double.infinity,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                                        title: Text('${menuItem.meatChoice[index].title}  +${menuItem.meatChoice[index].price}kr,-'),
                                        trailing: Container(
                                          width: 130,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                  icon: Icon(Icons.remove),
                                                  iconSize: 30,
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    if (menuItem.meatChoice[index].amount >= 1) {
                                                      setModalState(() {
                                                        menuItem.meatChoice[index].amount--;
                                                      });
                                                    }
                                                  }),
                                              Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Text(menuItem.meatChoice[index].amount.toString()),
                                              ),
                                              IconButton(
                                                  icon: Icon(Icons.add),
                                                  iconSize: 30,
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    if (totalExtraMeat < itemAmount) {
                                                      setModalState(() {
                                                        menuItem.meatChoice[index].amount++;
                                                      });
                                                    }
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                ),
                              ]),
                        Text(menuItem.title, textScaleFactor: 1.5),
                        Text(menuItem.price.toString() + ' kr,-'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.remove),
                                iconSize: 35,
                                color: Colors.red,
                                onPressed: () {
                                  if (itemAmount > 1) {
                                    setModalState(() {
                                      itemAmount--;
                                      // menuItem.meatChoice.forEach(
                                      //     (element) => element.amount = 0);
                                    });
                                  }
                                }),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(itemAmount.toString(), textScaleFactor: 3),
                            ),
                            IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 35,
                                color: Colors.green,
                                onPressed: () {
                                  setModalState(() {
                                    itemAmount++;
                                  });
                                }),
                          ],
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45),
                          child: Text('Fjern fra ordre'),
                          textColor: Colors.red,
                          onPressed: () {
                            MealsLog.allMenus.forEach((element) {
                              updateOrder(element, menuItem, 0);
                            });

                            setState(() {});

                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                          child: Text('Færdig'),
                          onPressed: () {
                            MealsLog.allMenus.forEach((element) {
                              updateOrder(element, menuItem, itemAmount);
                            });

                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          });
        });
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
