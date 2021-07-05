import 'package:flutter/material.dart';

import '../../flavors.dart';
import '/Model/CategoryCard.dart';
import '../../Model/MealsLog.dart';
import '../../Model/MenuItem.dart';



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
      height: 100,
      child: Card(
        // color: categoryCard.selected ? Colors.yellow[900] : Colors.brown[900],
        color: categoryCard.selected ? F.appSecondaryColor[900] : F.appPrimaryColor[900],
        child: ListTile(
            trailing: Icon(
              categoryCard.selected ? Icons.expand_more : Icons.expand_less,
              color: Colors.white,
              size: 35,
            ),
            title: Text(categoryCard.title, style: titleTextTheme()),
            subtitle: Text(categoryCard.subtitle, style: textTheme()),
            isThreeLine: true,
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
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Center(),
              ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(meals[i].title),
                subtitle: Text(meals[i].description),
                leading: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Nr ${meals[i].id}',
                        style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // CircleAvatar(
                    //   radius: 15,
                    //   child: Text(
                    //     meals[i].id.toString(),
                    //     style: textTheme(),
                    //   ),
                    //   backgroundColor: Colors.green,
                    // ),
                    Text(
                      '${meals[i].price}kr.',
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ],
                ),
                // trailing: Text(
                //   meals[i].price.toString() + 'kr.',
                //   style: TextStyle(color: Colors.red, fontSize: 18),
                // ),
              ),
              Row(
                children: <Widget>[
                  addAndRemoveButton('Slet', meals[i].amount, Icon(Icons.remove), Colors.red, () => _changeAmount(meals[i], -1)),
                  Container(
                    width: 75,
                    height: 40,
                    child: Center(
                      child: Text(meals[i].amount.toString()),
                    ),
                  ),
                  addAndRemoveButton('Tilføj', meals[i].amount, Icon(Icons.add), Colors.green, () => _changeAmount(meals[i], 1)),
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
    return Expanded(
      child: Container(
        // color: amount > 0 && color == Colors.red ? Colors.grey : color,
        height: 40,
        child: TextButton.icon(
          onPressed: () => myOnPressed(),
          icon: icon,
          label: Text(text),
          style: TextButton.styleFrom(
            // padding: EdgeInsets.all(20),

            primary: Colors.white,
            backgroundColor: amount <= 0 && color == Colors.red ? Colors.grey : color,
          ),
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
