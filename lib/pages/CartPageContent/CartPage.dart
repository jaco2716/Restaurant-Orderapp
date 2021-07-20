import 'package:flutter/material.dart';
import 'package:restaurantorderapp/Logic/CalculateValues.dart';
import 'package:restaurantorderapp/MyWidgets/MyAppBar.dart';
import 'package:restaurantorderapp/MyWidgets/MyMenuWidgets/MyModalMeatChoice.dart';
import 'package:restaurantorderapp/model/NextPageEnum.dart';
import 'package:restaurantorderapp/pages/LoginPageContent/CheckLoginPage.dart';
import '../../flavors.dart';
import '../../model/MealsLog.dart';
import '../../model/MenuItem.dart';

class CartPage extends StatefulWidget {
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
          meatChoiceTotal += meat.price * meat.amount * element.amount;
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
        // Divider(
        //   height: 1,
        //   thickness: 2,
        // ),
        // ListTile(
        //   title: Text('Total'),
        //   trailing: Text(subtotal.toString() + ' kr,-'),
        // ),
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
          child: Column(
            children: [
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(appBar: MyAppBar(''), body:CheckLoginPage(NextPage.OrderPage, 'OrderPage', cartItems))));
                          },
                    child: Text('Gå til bestilling')),
              ),
            ],
          ),
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
              subtitle: menuItem.description.length == 0
                  ? null
                  : Text(
                      menuItem.description,
                      style: TextStyle(fontSize: 12),
                    ),
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
                                      '${(totalMeatChoicePrice[meatIndex] * menuItem.amount).toString()} kr,-',
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

  void _updateNewTotal(int changedValue) {
    setState(() {
      MealsLog.totalPrice += changedValue;
    });
  }

  showCartBottomSheet(BuildContext context, MenuItem menuItem) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return MyModalMeatChoice(meatChoices: menuItem.meatChoice, menuItem: menuItem, updateNewTotal: _updateNewTotal, cartPageModal: true);
        });
  }
}
