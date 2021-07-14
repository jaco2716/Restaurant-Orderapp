import 'package:flutter/material.dart';

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
        return Card(
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
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      // contentPadding: EdgeInsets.all(10),
                      // dense: true,
                      title: Text(meals[i].title),
                      subtitle: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(meals[i].description),
                            Text(
                              meals[i].price.toString() + 'kr,-',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      isThreeLine: true,

                    ),
                  ),
                  meals[i].amount != 0
                      ? Card(
                          color: F.appSecondaryColor[900],
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Text(
                              '${meals[i].amount.toString()}x',
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
                          addAndRemoveButton('Slet', meals[i].amount, Icon(Icons.remove), Colors.red, () => _changeAmount(meals[i], -1)),
                          addAndRemoveButton('Tilføj', meals[i].amount, Icon(Icons.add), Colors.green, () => _changeAmount(meals[i], 1)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }

  Widget addAndRemoveButton(String text, int amount, Icon icon, Color color, void Function() myOnPressed) {
    double bottomRadius = color == Colors.red ? 0 : 10;
    double topRadius = color == Colors.red ? 10 : 0;
    return Container(
      // color: amount > 0 && color == Colors.red ? Colors.grey : color,
      // width: 60,
      height: 40,
      child: Card(
        margin: EdgeInsets.all(2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
          bottomLeft: Radius.circular(bottomRadius),
          bottomRight: Radius.circular(bottomRadius),
        )),
        color: amount <= 0 && color == Colors.red ? Colors.grey : color,
        child: IconButton(
          onPressed: () => myOnPressed(),
          icon: icon,
          iconSize: 15,
          // label: Text(text),
          color: Colors.white,
          // style: TextButton.styleFrom(
          //   // padding: EdgeInsets.all(20),

          //   primary: Colors.white,
          //   backgroundColor: amount <= 0 && color == Colors.red ? Colors.grey : color,
          // ),
        ),
      ),
    );
  }

  _changeAmount(MenuItem meal, int op) {
    if (meal.amount > 0 || op > 0) {
      totalPrice += (meal.price * op);
      meal.amount += op;
      widget.notifyParent(totalPrice);
    }
  }
}
