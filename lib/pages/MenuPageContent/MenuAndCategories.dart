import 'package:flutter/material.dart';
import 'package:restaurantorderapp/MyWidgets/MyMenuWidgets/MenuElementListTile.dart';
import 'package:restaurantorderapp/MyWidgets/MyMenuWidgets/MyModalMeatChoice.dart';
import 'package:restaurantorderapp/model/MeatChoice.dart';

import '../../flavors.dart';
import '/model/CategoryCard.dart';
import '../../model/MealsLog.dart';
import '../../model/MenuItem.dart';

class MenuAndCategories extends StatefulWidget {
  final ValueChanged<int> notifyParent;
  final int totalCartPrice;

  const MenuAndCategories({required this.notifyParent, required this.totalCartPrice});

  @override
  _MenuAndCategoriesState createState() => _MenuAndCategoriesState();
}

class _MenuAndCategoriesState extends State<MenuAndCategories> {
  int totalPrice = 0;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    totalPrice = widget.totalCartPrice;

    return SingleChildScrollView(
      controller: _scrollController,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: MealsLog.allMenus.length,
        itemBuilder: (BuildContext context, int index) {
          return fullCategoryMenu(MealsLog.menuCategoryCards[index], MealsLog.allMenus[index]);
        },
      ),
    );
  }

  TextStyle textTheme() {
    return TextStyle(color: Colors.white);
  }

  TextStyle titleTextTheme() {
    return TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  }

  Widget fullCategoryMenu(CategoryCard categoryCard, List<MenuItem> meals) {
    return Column(
      children: [
        buildCategoryTile(categoryCard),
        categoryCard.selected ? buildMenuCard(meals) : Center(),
      ],
    );
  }

  Widget buildCategoryTile(CategoryCard categoryCard) {
    return Container(
      padding: EdgeInsets.only(top: 1),
      child: Container(
        color: categoryCard.selected ? F.appSecondaryColor[900] : F.appPrimaryColor[900],
        // color: categoryCard.selected ? Colors.white : Colors.grey,
        child: ListTile(
            trailing: Icon(
              categoryCard.selected ? Icons.expand_more : Icons.expand_less,
              color: Colors.white,
              size: 35,
            ),
            title: Text(categoryCard.title, style: titleTextTheme()),
            subtitle: Text(categoryCard.subtitle, style: textTheme()),
            isThreeLine: categoryCard.subtitle.length == 0 ? false : true,
            onTap: () {
              setState(() {
                categoryCard.selected = !categoryCard.selected;
              });
              if (categoryCard.selected) {
                _scrollController.animateTo(_scrollController.offset + 150, curve: Curves.easeInOut, duration: Duration(milliseconds: 400));
              }
            }),
      ),
    );
  }

  Widget buildMenuCard(List<MenuItem> meals) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (BuildContext context, int i) {
        int meatChoiceSelected = 0;

        meals[i].meatChoice.forEach((e) => meatChoiceSelected += e.amount);

        return Card(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          elevation: 5,
          child: Column(
            children: <Widget>[
              meals[i].image.length > 0
                  ? Image.asset(
                      meals[i].image,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Center(),
              MenuElementListTile(element: meals[i], notifyParent: widget.notifyParent, totalPrice: totalPrice, setModalState: setState),
              // menuListTile(meals[i], setState),
              // Row(
              //   children: [
              //     Expanded(
              //       child: ListTile(
              //         // contentPadding: EdgeInsets.all(10),
              //         // dense: true,
              //         title: Text(meals[i].title),
              //         subtitle: Container(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(meals[i].description),
              //               Text(
              //                 meals[i].price.toString() + 'kr,-',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ],
              //           ),
              //         ),
              //         isThreeLine: true,
              //       ),
              //     ),
              //     meals[i].amount != 0
              //         ? Card(
              //             color: F.appSecondaryColor[900],
              //             child: Center(
              //                 child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              //               child: Text(
              //                 '${meals[i].amount.toString()}x',
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //             )))
              //         : Center(),
              //     Center(
              //       child: Container(
              //         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              //         height: 100,
              //         width: 55,
              //         child: Column(
              //           children: <Widget>[
              //             addAndRemoveButton('Slet', meals[i].amount, Icon(Icons.remove), Colors.red, () => _changeAmount(meals[i], -1)),
              //             addAndRemoveButton('Tilføj', meals[i].amount, Icon(Icons.add), Colors.green, () => _changeAmount(meals[i], 1)),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              meals[i].amount != 0 && meals[i].meatChoice.length != 0
                  ? Column(
                      children: [
                        Divider(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// enableDrag: false,
                                    isScrollControlled: true,
                                    // isDismissible: false,
                                    context: context,
                                    builder: (modalContext) {
                                      return MyModalMeatChoice(
                                          meatChoices: meals[i].meatChoice,
                                          menuItem: meals[i],
                                          totalPrice: totalPrice,
                                          notifyParent: widget.notifyParent);
                                    });
                              },
                              child: Text(
                                'Tilføj ekstra',
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  '$meatChoiceSelected valgt',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ],
                    )
                  : Center(),

              meals[i].amount != 0 && meals[i].meatChoice.length != 0 && meatChoiceSelected != 0
                  ? Column(
                      children: [
                        Divider(
                          height: 1,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              List<MeatChoice> newMeatchoices = [];
                              meals[i].meatChoice.forEach((element) {
                                newMeatchoices.add(MeatChoice.clone(element));
                              });
                              newMeatchoices.forEach((element) {
                                element.amount = 0;
                              });
                              MenuItem newMenuItem = MenuItem(
                                  id: meals[i].id + 199,
                                  title: meals[i].title,
                                  description: meals[i].description,
                                  price: meals[i].price,
                                  image: meals[i].image,
                                  amount: 1,
                                  meatChoice: newMeatchoices);

                              meals.insert(i + 1, newMenuItem);
                              totalPrice += newMenuItem.price;
                              widget.notifyParent(totalPrice);
                            },
                            child: Text(
                              'Tilføj ny ${meals[i].title} uden ekstra',
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(),
            ],
          ),
        );
      },
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }

  // Widget addAndRemoveButton(String text, int amount, Icon icon, Color color, void Function() myOnPressed) {
  //   double bottomRadius = color == Colors.red ? 0 : 10;
  //   double topRadius = color == Colors.red ? 10 : 0;
  //   return Container(
  //     // color: amount > 0 && color == Colors.red ? Colors.grey : color,
  //     // width: 60,
  //     height: 40,
  //     child: Card(
  //       margin: EdgeInsets.all(2),
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(topRadius),
  //         topRight: Radius.circular(topRadius),
  //         bottomLeft: Radius.circular(bottomRadius),
  //         bottomRight: Radius.circular(bottomRadius),
  //       )),
  //       color: amount <= 0 && color == Colors.red ? Colors.grey : color,
  //       child: IconButton(
  //         onPressed: () => myOnPressed(),
  //         icon: icon,
  //         iconSize: 15,
  //         // label: Text(text),
  //         color: Colors.white,
  //         // style: TextButton.styleFrom(
  //         //   // padding: EdgeInsets.all(20),

  //         //   primary: Colors.white,
  //         //   backgroundColor: amount <= 0 && color == Colors.red ? Colors.grey : color,
  //         // ),
  //       ),
  //     ),
  //   );
  // }

  // _changeAmount(dynamic element, int op) {
  //   if (element.amount > 0 || op > 0) {
  //     totalPrice += ((element.price as int) * op);
  //     element.amount += op;
  //     widget.notifyParent(totalPrice);
  //   }
  // }

//   showMeatChoiceModal(List<MeatChoice> meatChoices, MenuItem menuItem) {
//     showModalBottomSheet(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // enableDrag: false,
//       isScrollControlled: true,
//       // isDismissible: false,
//       context: context,
//       builder: (modalContext) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height - 100,
//           child: Column(
//             children: [
//               Card(
//                 color: Colors.grey[300],
//                 child: SizedBox(
//                   width: 100,
//                   height: 5,
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('${menuItem.title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 12.0),
//                 child: Text('Tilføj ekstra tilbehør.'),
//               ),
//               Divider(
//                 height: 1,
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height - 180,
//                 child: Stack(children: [
//                   StatefulBuilder(builder: (BuildContext context, setModalState) {
//                     return ListView.separated(
//                       itemCount: meatChoices.length,
//                       padding: EdgeInsets.only(bottom: 80),
//                       shrinkWrap: true,
//                       itemBuilder: (BuildContext context, int index) {
//                         return menuListTile(meatChoices[index], setModalState);
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return Divider(
//                           height: 1,
//                         );
//                       },
//                     );
//                   }),
//                   Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         width: double.infinity,
//                         child: ElevatedButton(
//                             // style: ElevatedButton.styleFrom(
//                             //   padding: EdgeInsets.all(15)
//                             // ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('Færdig')),
//                       ))
//                 ]),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

  // Widget menuListTile(dynamic element, void Function(void Function()) setModalState) {
  //   String? description;
  //   try {
  //     description = element.description;
  //   } catch (e) {
  //     description = null;
  //   }
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: ListTile(
  //           // contentPadding: EdgeInsets.all(10),
  //           // dense: true,
  //           title: Text(element.title),
  //           subtitle: Container(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 description != null ? Text(description) : Center(),
  //                 Text(
  //                   element.price.toString() + 'kr,-',
  //                   style: TextStyle(color: Colors.blue),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           isThreeLine: true,
  //         ),
  //       ),
  //       element.amount != 0
  //           ? Card(
  //               color: F.appSecondaryColor[900],
  //               child: Center(
  //                   child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
  //                 child: Text(
  //                   '${element.amount.toString()}x',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               )))
  //           : Center(),
  //       Center(
  //         child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
  //           height: 100,
  //           width: 55,
  //           child: Column(
  //             children: <Widget>[
  //               addAndRemoveButton('Slet', element.amount, Icon(Icons.remove), Colors.red, () {
  //                 setModalState(() {
  //                   _changeAmount(element, -1);
  //                 });
  //               }),
  //               addAndRemoveButton('Tilføj', element.amount, Icon(Icons.add), Colors.green, () {
  //                 setModalState(() {
  //                   _changeAmount(element, 1);
  //                 });
  //               }),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
