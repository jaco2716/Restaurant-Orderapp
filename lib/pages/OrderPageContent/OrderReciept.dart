import 'package:flutter/material.dart';
import 'package:restaurantorderapp/Logic/CalculateValues.dart';
import 'package:restaurantorderapp/model/MenuItem.dart';
import '../../flavors.dart';

class OrderReciept extends StatelessWidget {
  final List<MenuItem> cartItems;
  OrderReciept(this.cartItems);
  final CalculateValues _calculateValues = CalculateValues();

  TextStyle smallTextStyle = TextStyle(fontSize: 10, color: Colors.grey[700]);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Din ordre',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
                ),
              ),
              Text('Kun Takeaway', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[700])),
              Text(
                'For at spise i restaranten skal du ringe til ${F.companyPhone}',
                textAlign: TextAlign.center,
              ),
              Divider(
                color: Colors.black,
              ),
              buildCart(cartItems),
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: totalpriceStyle(),
                  ),
                  Text(
                    '${_calculateValues.totalPriceFromOrder(cartItems)} kr,-',
                    style: totalpriceStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle totalpriceStyle() {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  Widget buildCart(List<MenuItem> menuItem) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 10),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: menuItem.length,
      itemBuilder: (BuildContext context, int index) {
        return cartTile(menuItem[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 10,
        );
      },
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${menuItem.amount.toString()}x  ${menuItem.title}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(totalItemPrice.toString() + ' kr,-'),
                // ListTile(
                //   minVerticalPadding:0,
                //   contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                //   title: Text('${menuItem.amount.toString()}x  ${menuItem.title}'),
                //   // leading: Text(
                //   //   '${menuItem.amount.toString()}',
                //   // ),
                //   // subtitle: menuItem.meatChoice.length != 0
                //   //     ? ListView.builder(
                //   //         itemCount: menuItem.meatChoice.length,
                //   //         itemBuilder: (BuildContext context, int meatIndex) {
                //   //           // print('meatamount: ' +
                //   //           //     menuItem.meatChoice[meatIndex].amount.toString());
                //   //           return menuItem.meatChoice[meatIndex].amount != 0
                //   //               ? Container(
                //   //                   height: 15,
                //   //                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                //   //                     Text(
                //   //                       '     - ${menuItem.meatChoice[meatIndex].amount}x ${menuItem.meatChoice[meatIndex].title}',
                //   //                     ),
                //   //                     Text(
                //   //                       '+ ${totalMeatChoicePrice[meatIndex].toString()}kr,-',
                //   //                     ),
                //   //                   ]),
                //   //                 )
                //   //               : Container();
                //   //         },
                //   //         shrinkWrap: true,
                //   //         physics: NeverScrollableScrollPhysics(),
                //   //       )
                //   //     : null,
                //   trailing: Text(totalItemPrice.toString() + ' kr,-'),
                //   dense: true,
                // ),
              ],
            ),
          ),
          menuItem.meatChoice.length != 0
              ? totalMeatChoiceAmount > 1
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: menuItem.meatChoice.length,
                      itemBuilder: (BuildContext context, int meatIndex) {
                        return menuItem.meatChoice[meatIndex].amount != 0
                            ? Container(
                                height: 15,
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Text(
                                    '     - ${menuItem.meatChoice[meatIndex].amount}x ${menuItem.meatChoice[meatIndex].title}',
                                    style: smallTextStyle,
                                  ),
                                  Text(
                                    '+ ${totalMeatChoicePrice[meatIndex].toString()}kr,-',
                                    style: smallTextStyle,
                                  ),
                                ]),
                              )
                            : Center();
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    )
                  : Center()
              : Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    menuItem.description,
                    style: smallTextStyle,
                  ),
                )
        ],
      ),
    );
  }
}
