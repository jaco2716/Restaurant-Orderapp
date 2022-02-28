import 'package:flutter/material.dart';
import 'package:restaurantorderapp/model/MeatChoice.dart';

import 'model/CategoryCard.dart';
import 'model/MenuItem.dart';

enum Flavor {
  orderappTest,
  ilmolino,
  chiangmai,
}

class F {
  static Flavor? appFlavor;
  static String get appTitle {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return 'Orderapptest';
      case Flavor.ilmolino:
        return 'IL MOLINO';
      case Flavor.chiangmai:
        return 'Chiang Mai Køge';
      default:
        return 'Testing';
    }
  }

  static String get companyWebsite {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return 'https://orderapptest.dk';
      case Flavor.ilmolino:
        return 'https://ilmolinolyngby.dk';
      case Flavor.chiangmai:
        return 'https://chiangmairestaurant.dk/';
      default:
        return 'companyWebsite';
    }
  }

  static String get companyPhone {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return '+45 12 34 56 78';
      case Flavor.ilmolino:
        return '+45 45 88 51 10';
      case Flavor.chiangmai:
        return '+45 34 11 68 68';
      default:
        return 'companyPhone';
    }
  }

  static String get companyAddress {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return 'test addresse og noget mere';
      case Flavor.ilmolino:
        return 'Gammel Lundtoftevej 14, 2800 Kongens Lyngby';
      case Flavor.chiangmai:
        return 'Havnen 23B, 4600 Køge';
      default:
        return 'companyAddress';
    }
  }

  static String get privacyPolicyURL {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return 'https://www.termsfeed.com/live/yourPolicy';
      case Flavor.ilmolino:
        return 'https://www.termsfeed.com/live/yourPolicy';
      case Flavor.chiangmai:
        return 'https://www.termsfeed.com/live/yourPolicy';
      default:
        return 'privacyPolicyURL';
    }
  }

  static MaterialColor get appPrimaryColor {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return Colors.green;
      case Flavor.ilmolino:
        return Colors.brown;
      case Flavor.chiangmai:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }

  static MaterialColor get appSecondaryColor {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return Colors.lightGreen;
      case Flavor.ilmolino:
        return Colors.yellow;
      case Flavor.chiangmai:
        return Colors.yellow;
      default:
        return Colors.lightBlue;
    }
  }

  static String get appIconPathLight {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return 'assets/orderapptest/icons/iconlight.png';
      case Flavor.ilmolino:
        return 'assets/ilmolino/icons/iconlight.png';
      case Flavor.chiangmai:
        return 'assets/chiangmai/icons/iconlight.png';
      default:
        return '';
    }
  }

  static String get appIconPathDark {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return 'assets/orderapptest/icons/icondark.png';
      case Flavor.ilmolino:
        return 'assets/ilmolino/icons/icondark.png';
      case Flavor.chiangmai:
        return 'assets/chiangmai/icons/icondark.png';
      default:
        return '';
    }
  }

  static String get firestoreCollection {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return 'application/orderapptest';
      case Flavor.ilmolino:
        return 'application/ilmolino';
      case Flavor.chiangmai:
        return 'application/chiangmai';
      default:
        return 'application/testing';
    }
  }

  static String get baseURL {
    return 'https://fcm.googleapis.com';
    // switch (appFlavor) {
    //   case Flavor.orderappTest:
    //     return 'https://fcm.googleapis.com';
    //   case Flavor.ilmolino:
    //     return 'https://fcm.googleapis.com';
    //   case Flavor.chiangmai:
    //     return 'https://fcm.googleapis.com';
    //   default:
    //     return 'https://fcm.googleapis.com';
    // }
  }

  static String get serverToken {
    //TODO get server token?
    switch (appFlavor) {
      case Flavor.orderappTest:
        return '';
      case Flavor.ilmolino:
        return '';
      case Flavor.chiangmai:
        return '';
      default:
        return '';
    }
  }

  static List<List<MenuItem>> get allMenus {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return [
          //SANDWICHES
          [
            MenuItem(id: 1, title: 'CLUB SANDWICH Test', description: 'Med kylling, bacon og pesto', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 2,
                title: 'Serano SANDWICH Test',
                description: 'Med frisk mozzarella eller gorgonzola, serano og pesto',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 3,
                title: 'LAKSE SANDWICH Test',
                description: 'Med røget laks og hjemmelavet dilddressing',
                price: 75,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 4,
                title: 'BACON AVOKADO Test',
                description: 'Med luksus bacon, frisk avokado og pesto',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 5,
                title: 'TUNO Test',
                description: 'Med hjemmelavet tunmousse og pesto',
                price: 75,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
          ],

//SALATER
          [
            MenuItem(
                id: 6,
                title: 'INSALATA CAPRESE Test',
                description: 'Med frisk mozzarella, frisk basilikum, stilk tomat og hjemmelavet pesto',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 7,
                title: 'KYLLING & BACON Test',
                description: 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 8,
                title: 'HJEMMELAVET TUNCREME Test',
                description: 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 9,
                title: 'KYLLING PASTA SALAT Test',
                description: 'Serveres med penne, peberfrugt, semi-dried tomater, rucola, oliven og pesto',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

//OMELETTER
          [
            MenuItem(
                id: 10,
                title: 'KYLLING OG BACON Test',
                description: 'Med kylling og bacon og cheddarost',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 11,
                title: 'VEGETAR OMELET Test',
                description: 'Med grillede grøntsager, champignon og cheddarost',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 12,
                title: 'HUSETS OMELET Test',
                description: 'Med løg, bacon, cherry tomater, olivenolie og cheddarost',
                price: 85,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
          ],

//PASTA RETTER
          [
            MenuItem(id: 13, title: 'LASAGNE Test', description: 'Med kødsauce', price: 89, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 14,
                title: 'SPAGHETTI BOLOGNESE Test',
                description: 'Spaghetti med kødsauce',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 15,
                title: 'SPAGHETTI ALLA CARBONARE Test',
                description: 'Med bacon, æg, flødesauce og frisk parmesan',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 16,
                title: 'PASTA PESTO Test',
                description: 'Penne med kylling, hjemmelavet pesto og frisk grana',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 17,
                title: 'SPAGHETTI CON CARNE Test',
                description: 'Med bøfstrimler, løg, champignon, pomodore og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 18,
                title: 'SPAGHETTI ALLA GORGONZOLA Test',
                description: 'Med gorgonzola, serano og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 19,
                title: 'PENNE ALLA LAKS Test',
                description: 'Med røget laks og pomodore, pesto og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 20,
                title: 'TORTELLINI PANNA PROSCIUTTO Test',
                description: 'Med skinke, løg, champignon, pomodore og ost',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 21,
                title: 'PENNE VEGETALI Test',
                description: 'Med grillede grøntsager, løg, champignon, pomodore og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //ALLA CARTE
          [
            MenuItem(
                id: 22,
                title: 'BØF CLASSICA Test',
                description: 'Mør og saftig oksefilet med bearnaisesauce og italiensk rosmarin kartofler',
                price: 159,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 23,
                title: 'HVIDLØGS BØF Test',
                description: 'Mør og lækker oksefilet marineret med hvidløg, creme fraiche og kartofler',
                price: 159,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 24,
                title: 'HUSETS BØF Test',
                description: 'Mør og saftig oksefilet med hjemmelavet whisky sauce og italienske rosmarin kartofler',
                price: 169,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 25,
                title: 'TARTUFO Test',
                description: 'Mør og saftig oksefilet med hjemmelavet trøffel sauce og italienske rosmarin kartofler',
                price: 169,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //PIZZA
          [
            MenuItem(id: 30, title: 'MARGHERITA Test', description: 'Tomat og ost', price: 65, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 31, title: 'CAPRICCIOSA Test', description: 'Skinke og champignon', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 32,
                title: 'CACCIATORE Test',
                description: 'Pepperoni, oliven og friske tomater',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 33, title: 'CALZONE (INDBAGT) Test', description: 'Med skinke og champignon', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 34, title: 'HAWAII Test', description: 'Skinke og ananas', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 35,
                title: 'NAPOLI Test',
                description: 'Ansjoser, oliven, løg, kapers og hvidløg',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 36, title: 'POLO Test', description: 'Med kylling, frisk tomat og rucola', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 37,
                title: 'ESTATE Test',
                description: 'Med serano , rucola, frisk grana og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 38,
                title: 'PEPINO Test',
                description: 'Med italiensk salami, rucola, frisk grana og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 39,
                title: 'PERIMAVERA Test',
                description: 'Med frisk mozzarella, frisk tomat, basilicum og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 40, title: 'PARMA Test', description: 'Med gorgonzola, champignon og serano', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 41,
                title: 'MONZESE Test',
                description: 'Med spinat, gorgonzola, grana, chili og hvidløg',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 42,
                title: 'SPINACI Test',
                description: 'Med røget laks, spinat, rejer og hvidløg',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 43,
                title: 'PATATA Test',
                description: 'Med kartofler, frisk mozzarella, frisk rosmarin og oliven',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 44,
                title: 'CONTADINA Test',
                description: 'Med frisk mozzarella, kylling, stegt bacon og spinat',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 45,
                title: 'MONDENA Test',
                description: 'Med frisk mozzarella, rucola, cherry tomater og frisk grana',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 46,
                title: 'HUSETS SPECIAL Test',
                description: 'Med italiensk bøfstrimler, løg, peberfrugt, champignon og sød sennep',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 47,
                title: 'SICILIA Test',
                description: 'Med frisk avokado, luksus bacon og cherry tomater m/u pesto',
                price: 89,
                image: 'assets/orderapptest/menu/1.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 48,
                title: 'DELLA CASA Test',
                description: 'Oksekød, bacon, tomater, løg, peberfrugt og kapers',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],
        ];
      case Flavor.ilmolino:
        return [
          //SANDWICHES
          [
            MenuItem(id: 1, title: 'CLUB SANDWICH', description: 'Med kylling, bacon og pesto', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 2,
                title: 'Serano SANDWICH',
                description: 'Med frisk mozzarella eller gorgonzola, serano og pesto',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 3,
                title: 'LAKSE SANDWICH',
                description: 'Med røget laks og hjemmelavet dilddressing',
                price: 75,
                image: 'assets/ilmolino/menu/3.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 4,
                title: 'BACON AVOKADO',
                description: 'Med luksus bacon, frisk avokado og pesto',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 5,
                title: 'TUNO',
                description: 'Med hjemmelavet tunmousse og pesto',
                price: 75,
                image: 'assets/ilmolino/menu/5.jpg',
                amount: 0,
                meatChoice: []),
          ],

//SALATER
          [
            MenuItem(
                id: 6,
                title: 'INSALATA CAPRESE',
                description: 'Med frisk mozzarella, frisk basilikum, stilk tomat og hjemmelavet pesto',
                price: 89,
                image: 'assets/ilmolino/menu/6.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 7,
                title: 'KYLLING & BACON',
                description: 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 8,
                title: 'HJEMMELAVET TUNCREME',
                description: 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto',
                price: 89,
                image: 'assets/ilmolino/menu/8.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 9,
                title: 'KYLLING PASTA SALAT',
                description: 'Serveres med penne, peberfrugt, semi-dried tomater, rucola, oliven og pesto',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

//OMELETTER
          [
            MenuItem(
                id: 10,
                title: 'KYLLING OG BACON',
                description: 'Med kylling og bacon og cheddarost',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 11,
                title: 'VEGETAR OMELET',
                description: 'Med grillede grøntsager, champignon og cheddarost',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 12,
                title: 'HUSETS OMELET',
                description: 'Med løg, bacon, cherry tomater, olivenolie og cheddarost',
                price: 85,
                image: 'assets/ilmolino/menu/12.jpg',
                amount: 0,
                meatChoice: []),
          ],

//PASTA RETTER
          [
            MenuItem(id: 13, title: 'LASAGNE', description: 'Med kødsauce', price: 89, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 14,
                title: 'SPAGHETTI BOLOGNESE',
                description: 'Spaghetti med kødsauce',
                price: 89,
                image: 'assets/ilmolino/menu/14.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 15,
                title: 'SPAGHETTI ALLA CARBONARE',
                description: 'Med bacon, æg, flødesauce og frisk parmesan',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 16,
                title: 'PASTA PESTO',
                description: 'Penne med kylling, hjemmelavet pesto og frisk grana',
                price: 89,
                image: 'assets/ilmolino/menu/16.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 17,
                title: 'SPAGHETTI CON CARNE',
                description: 'Med bøfstrimler, løg, champignon, pomodore og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 18,
                title: 'SPAGHETTI ALLA GORGONZOLA',
                description: 'Med gorgonzola, serano og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 19,
                title: 'PENNE ALLA LAKS',
                description: 'Med røget laks og pomodore, pesto og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 20,
                title: 'TORTELLINI PANNA PROSCIUTTO',
                description: 'Med skinke, løg, champignon, pomodore og ost',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 21,
                title: 'PENNE VEGETALI',
                description: 'Med grillede grøntsager, løg, champignon, pomodore og frisk grana',
                price: 95,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //ALLA CARTE
          [
            MenuItem(
                id: 22,
                title: 'BØF CLASSICA',
                description: 'Mør og saftig oksefilet med bearnaisesauce og italiensk rosmarin kartofler',
                price: 159,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 23,
                title: 'HVIDLØGS BØF',
                description: 'Mør og lækker oksefilet marineret med hvidløg, creme fraiche og kartofler',
                price: 159,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 24,
                title: 'HUSETS BØF',
                description: 'Mør og saftig oksefilet med hjemmelavet whisky sauce og italienske rosmarin kartofler',
                price: 169,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 25,
                title: 'TARTUFO',
                description: 'Mør og saftig oksefilet med hjemmelavet trøffel sauce og italienske rosmarin kartofler',
                price: 169,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //PIZZA
          [
            MenuItem(id: 30, title: 'MARGHERITA', description: 'Tomat og ost', price: 65, image: '', amount: 0, meatChoice: [
              MeatChoice(1, 'Oliven', 5, 0),
              MeatChoice(2, 'Salat', 5, 0),
              MeatChoice(3, 'Pesto', 5, 0),
              MeatChoice(4, 'Agurk', 5, 0),
              MeatChoice(5, 'Chilli', 5, 0),
              MeatChoice(6, 'Salt', 5, 0),
              MeatChoice(7, 'Peber', 5, 0),
              MeatChoice(8, 'Paprika', 5, 0),
              MeatChoice(9, 'Hvidløg', 5, 0),
              MeatChoice(10, 'Løg', 5, 0),
            ]),
            MenuItem(id: 31, title: 'CAPRICCIOSA', description: 'Skinke og champignon', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 32, title: 'CACCIATORE', description: 'Pepperoni, oliven og friske tomater', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 33, title: 'CALZONE (INDBAGT)', description: 'Med skinke og champignon', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 34, title: 'HAWAII', description: 'Skinke og ananas', price: 75, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 35, title: 'NAPOLI', description: 'Ansjoser, oliven, løg, kapers og hvidløg', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 36, title: 'POLO', description: 'Med kylling, frisk tomat og rucola', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 37, title: 'ESTATE', description: 'Med serano , rucola, frisk grana og pesto', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 38,
                title: 'PEPINO',
                description: 'Med italiensk salami, rucola, frisk grana og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 39,
                title: 'PERIMAVERA',
                description: 'Med frisk mozzarella, frisk tomat, basilicum og pesto',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 40, title: 'PARMA', description: 'Med gorgonzola, champignon og serano', price: 85, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 41,
                title: 'MONZESE',
                description: 'Med spinat, gorgonzola, grana, chili og hvidløg',
                price: 85,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 42, title: 'SPINACI', description: 'Med røget laks, spinat, rejer og hvidløg', price: 89, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 43,
                title: 'PATATA',
                description: 'Med kartofler, frisk mozzarella, frisk rosmarin og oliven',
                price: 89,
                image: 'assets/ilmolino/menu/43.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 44,
                title: 'CONTADINA',
                description: 'Med frisk mozzarella, kylling, stegt bacon og spinat',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 45,
                title: 'MONDENA',
                description: 'Med frisk mozzarella, rucola, cherry tomater og frisk grana',
                price: 89,
                image: 'assets/ilmolino/menu/45.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 46,
                title: 'HUSETS SPECIAL',
                description: 'Med italiensk bøfstrimler, løg, peberfrugt, champignon og sød sennep',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 47,
                title: 'SICILIA',
                description: 'Med frisk avokado, luksus bacon og cherry tomater m/u pesto',
                price: 89,
                image: 'assets/ilmolino/menu/47.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 48,
                title: 'DELLA CASA',
                description: 'Oksekød, bacon, tomater, løg, peberfrugt og kapers',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //SPECIALITETER
          [
            MenuItem(
                id: 50,
                title: 'CAFE BURGER',
                description: '200 gram hakkebøf med cheddarost i økologisk bolle og italiensk rosmarin kartofler',
                price: 119,
                image: 'assets/ilmolino/menu/50.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 51,
                title: 'CHILLI CON CARNE',
                description: 'Tilberedt med hjemmelavet salsa, nachos, brød og creme fraiche',
                price: 109,
                image: 'assets/ilmolino/menu/51.jpg',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 52,
                title: 'BURRITO',
                description: 'Ovnbagte meltortillas med bønner, oksekød, tortilla chips og salat',
                price: 109,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 53,
                title: 'NACHOS',
                description: 'Tortila chips med kylling, ost og salsa eller guacamole',
                price: 89,
                image: '',
                amount: 0,
                meatChoice: []),
          ],

          //ZUPPA/SUPPE
          [
            MenuItem(id: 60, title: 'CREMA DI POMODORO', description: 'Tomat suppe med brød', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 61, title: 'ZUPPA DI VERDURE', description: 'Grøntsags suppe med brød', price: 59, image: '', amount: 0, meatChoice: []),
          ],

          //BØRNE MENU
          [
            MenuItem(id: 62, title: 'SPAGHETTI BOLOGNESE', description: 'Spaghetti med kødsauce', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 63, title: 'PIZZA BAMBINO', description: 'Med tomat, ost, skinke og pølser', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 64, title: 'LASAGNE BAMBINO', description: 'Lasagne med kødsauce', price: 59, image: '', amount: 0, meatChoice: []),
          ],

          //DESSERTER
          [
            MenuItem(
                id: 70,
                title: 'CRESPELE CON GELATO',
                description: 'Pandekage med italiensk is og chokoladesauce',
                price: 59,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 71, title: 'GELATO DELLA CASA', description: 'Husets is med chokolade sauce', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 72, title: 'TORTA VARM DRIK', description: 'Med italiensk kage', price: 59, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 73, title: 'DESSERT PIZZA', description: '', price: 75, image: '', amount: 0, meatChoice: []),
          ],

          //KOLDE DRIKKE
          [
            MenuItem(id: 90, title: 'Cola, Cola Zero, Sprite, Fanta', description: '', price: 27, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 91, title: 'Økologisk hyldeblomst eller solbær', description: '', price: 29, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 92, title: 'San Pellegrino med brus', description: '0,5 l.', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 93, title: 'Limonade', description: '0,5 l.', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 94, title: 'Aranciate Rossa', description: 'Blodappelsin 0,5 l.', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 95, title: 'Italiensk øl', description: 'Peroni', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 96, title: 'Tuborg profil', description: '', price: 30, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 97, title: 'La Rossa Moretti', description: '', price: 29, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 98, title: 'Italiensk kildevand', description: '', price: 22, image: '', amount: 0, meatChoice: []),
          ],

          //VARME DRIKKE
          [
            MenuItem(id: 100, title: 'Kaffe', description: '', price: 24, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 101, title: 'Espresso', description: '', price: 24, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 102, title: 'Dobbelt espresso', description: '', price: 32, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 103, title: 'Cappuccino', description: '', price: 30, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 104, title: 'Caffe latte', description: '', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 105, title: 'Café au lait', description: '', price: 35, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 106, title: 'Chai latte', description: '', price: 35, image: '', amount: 0, meatChoice: []),
          ],
        ];
      default:
        return [
          //Thai specialiteter
          [
            MenuItem(id: 1, title: 'PAPAYA SALAT', description: '', price: 125, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 2, title: 'GLASNUDLER', description: 'Serveres med seafood og chili', price: 130, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 3, title: 'TOM - YUM SEAFOOD', description: '', price: 120, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 4, title: 'HAKKET SVINEKØD ELLER KYLLING', description: 'Serveres med chili', price: 120, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 5, title: 'NAM TOK', description: '', price: 125, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 6, title: 'FLÆSKESTEG', description: 'Serveres med chili og basilikum', price: 125, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 7,
                title: 'OKSEKØD',
                description: 'Serveres med salat af friske grøntsager og chili',
                price: 135,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 8, title: 'SEAFOOD SALAT', description: 'Serveres med chili', price: 130, image: '', amount: 0, meatChoice: []),
          ],
          //Supper
          [
            MenuItem(
                id: 9,
                title: 'TOM YUM GUNG',
                description: 'Tom Yum Gung suppe serveret med rejer ( med eller uden kokosmælk)',
                price: 65,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 10,
                title: 'TOM YUNG GAY',
                description: 'Tom Yung suppe serveret med kylling (med eller kuden kokosmælk)',
                price: 60,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 11, title: 'TOM KHA GUNG', description: 'Kokosmælkssuppe serveret med rejer', price: 65, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 12, title: 'TOM KHA GAY', description: 'Kokosmælkssuppe serveret med kylling', price: 60, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 13,
                title: 'WANTOM SUPPE',
                description: 'Wanton suppe serveret med hakket svinekød',
                price: 60,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 14,
                title: 'GRØNTSSAGSSUPPE',
                description: 'En lækker grøntssagssuppe serveret med kylling',
                price: 60,
                image: '',
                amount: 0,
                meatChoice: []),
          ],
          //Forretter
          [
            MenuItem(
                id: 15,
                title: 'THAI PO PAI',
                description: 'Thai forårsruller serveret med sød chilisauce',
                price: 60,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 16,
                title: 'SATAY GHAI',
                description: 'Grillspyd af kylling serveret med jordnøddesmør',
                price: 60,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 17,
                title: 'THAI REJECHIPS',
                description: 'Rejechips serveret med sød chili sauce (vælg mellem hvide eller brune chips)',
                price: 35,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 18,
                title: 'FRITURESTEGT WANTON',
                description: 'Serveres med indbagt svinekød og koriander',
                price: 60,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 19,
                title: 'STORE HJEMMELAVEDE FORÅRSRULLER',
                description: 'Serveres med hakket oksekød',
                price: 60,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 20,
                title: 'FRISTURESTEGTE REJER (4 STK.)',
                description: 'Serveres med sød chili sause',
                price: 65,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 21, title: 'RIBBENSSTEG', description: 'Serveres med løg', price: 65, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 22, title: 'KYLLINGEVINGER (THAI STIL)', description: '', price: 60, image: '', amount: 0, meatChoice: []),
          ],
          //Kylling Retter
          [
            MenuItem(
                id: 23,
                title: 'GHAI PAT GLA PAU 🔥',
                description: 'Stegt hakket kylling, chili og frisk basilikum',
                price: 125,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 24,
                title: 'GHAI PAT MEDMAMOUNG HI MA PAN',
                description: 'Stegt kylling serveret med cashewnødder',
                price: 125,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 25, title: 'CHICKEN FRIED WITH CASCHEWNUTS THAI STYLE 🔥', description: '', price: 125, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 26, title: 'GHAI PAT PRIEW WAHN', description: 'Stegt kylling i sur-sød-sovs', price: 125, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 27,
                title: 'GHAI PAT PAK RUAM MIT',
                description: 'Kylling serveret med blandede grøntsager',
                price: 125,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 28, title: 'GHAI PAT KING', description: 'Kylling med ingefær', price: 125, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 29, title: 'PA NANG GHAI', description: 'Pa nang karry serveret med kylling', price: 125, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 30,
                title: 'GAENG KARRE GHAI',
                description: 'Kylling i gul karry serveret med grøntsager',
                price: 125,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 31,
                title: 'GAENG PET GHAI',
                description: 'Kylling i stærkt rød karry serveret med bambusskud',
                price: 125,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 32,
                title: 'GAENG KIEW WAHN GHAI 🔥',
                description: 'Kylling med stærkt grøn karry serveret med bambusskud',
                price: 125,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 33,
                title: 'MASSAMAN GHAI',
                description: 'Masaman karry med kokosmælk serveret med kartofler',
                price: 125,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 34,
                title: 'INDBAGT KYLLING ELLER SVINEKØD',
                description: 'Serveres med sur-sød sauce',
                price: 125,
                image: '',
                amount: 0,
                meatChoice: []),
          ],
          // Svinekød Retter
          [
            MenuItem(
                id: 35,
                title: 'MOOH PAT GLAU PAU 🔥',
                description: 'Stegt hakket svinekød med chili og stærk basilikum',
                price: 120,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 36,
                title: 'MOOH PAT PAK RUAM MIT',
                description: 'Stegt svinekød serveret med blandede grøntsager',
                price: 120,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 37,
                title: 'GANG PAT MOOH',
                description: 'Stærk rød karry serveret med svinekød og kokosmælk',
                price: 120,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 38,
                title: 'GANG KIEW WAHN MOO',
                description: 'Stærk grøn karry serveret med svinekød og kokosmælk',
                price: 120,
                image: '',
                amount: 0,
                meatChoice: []),
          ],
          // Oksekød Retter
          [
            MenuItem(
                id: 39,
                title: 'PAT GLA PAU NUEP 🔥',
                description: 'Stegt hakket oksekød med chili og frisk basilikum',
                price: 139,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 40,
                title: 'NUEPAT NUM MAN HOY',
                description: 'Stegt oksekød serveret med østerssauce',
                price: 139,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 41, title: 'PA NANG NUEP', description: 'Pa nang karry serveret med oksekød', price: 139, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 42,
                title: 'GAENG KIEW WAHN NUEP 🔥',
                description: 'Stærk grøn karry serveret med oksekød',
                price: 139,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 43,
                title: 'GAENG PAT NUEP 🔥',
                description: 'Masaman karry med kokosmælk serveret med kartoflerStærk rød karry serveret med oksekød',
                price: 139,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 44,
                title: 'NUEP PAT BROCCOLI',
                description: 'Stegt oksekød serveret med broccoli',
                price: 139,
                image: '',
                amount: 0,
                meatChoice: []),
          ],
          // Børnemenu 🧒👧
          [
            MenuItem(id: 45, title: 'POMMES FRITES', description: 'Serveres med remoulade', price: 45, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 46,
                title: 'BØRNEMENU 1 (MED 2 KUGLER IS)',
                description: 'Friturestegt kylling med pommes frites',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 47,
                title: 'BØRNEMENU 3 (MED 2 KUGLER IS)',
                description: 'Stegteris med kylling og grøntsager',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 48,
                title: 'BØRNEMENU 4 (MED 2 KUGLER IS)',
                description: 'Stegte nudler med kylling og grøntsager',
                price: 75,
                image: '',
                amount: 0,
                meatChoice: []),
          ],
          // Alt godt fra havet
          [
            MenuItem(
                id: 49,
                title: 'GANG KIEWWAHNGUNG',
                description: 'Stærk grøn karry serveret med rejer og kokosmælk',
                price: 145,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 50,
                title: 'GUNG TROD',
                description: 'Dybtstegte rejer serveret med sur-sød sauce',
                price: 145,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(
                id: 51, title: 'THAI FISKEFRIKADELLER', description: 'Serveres med sur-sød sauce', price: 125, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 52, title: 'INDBAGT FISK', description: 'Serveres med sur-sød sauce', price: 145, image: '', amount: 0, meatChoice: []),
          ],
          // Vegetar
          [
            MenuItem(id: 53, title: 'CHOPSUEY', description: 'Lynstegte grøntsager', price: 95, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 54, title: 'STEGTE RIS', description: 'Serveres med grøntsager', price: 95, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 55, title: 'STEGTE NUDLER', description: 'Serveres med grøntsager', price: 95, image: '', amount: 0, meatChoice: []),
          ],
          // And
          [
            MenuItem(
                id: 56, title: 'STEGT AND', description: 'Serveres med bambusskud og champignon', price: 145, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 57,
                title: 'CHOP SUEY',
                description: 'Lynstegte grøntsager serveres med stegt and.',
                price: 145,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 58, title: 'STEGT AND I SUR-SØD SAUCE', description: '', price: 145, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 59,
                title: 'STEGT AND 🔥',
                description: 'Serveres med rød karry i kokosmælk og tomater',
                price: 145,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 60, title: 'STEGT AND M. PAH CHOI', description: 'Serveres i østerssauce', price: 145, image: '', amount: 0, meatChoice: []),
          ],
          // Stegte ris og nudler
          [
            MenuItem(
                id: 61,
                title: 'STEGTE RIS DE LUXE M. REJSER OG KYLLING & GRØNTSAGER',
                description: '',
                price: 120,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 62, title: 'STEGTE RIS M. KYLLING OG GRØNTSAGER', description: '', price: 110, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 63, title: 'STEGTE RIS M. KARRY, KYLLING OG GRØNTSAGER', description: '', price: 110, image: '', amount: 0, meatChoice: []),
            MenuItem(
                id: 64,
                title: 'STEGTE NUDLER DE LUXE M. REJER, KYLLING OG GRØNTSAGER',
                description: '',
                price: 120,
                image: '',
                amount: 0,
                meatChoice: []),
            MenuItem(id: 65, title: 'STEGTE RISNUDLER M. KYLLING OG GRØNTSAGER', description: '', price: 110, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 66, title: 'STEGTE RISNUDLER MED OKSEKØD OG GRØNTSAGER', description: '', price: 110, image: '', amount: 0, meatChoice: []),
            MenuItem(id: 67, title: 'PADTHAI MED REJER', description: '', price: 120, image: '', amount: 0, meatChoice: []),
          ],
        ];
    }
  }
  // MenuItem(id: 9, title: '', description: '', price: 0, image: '', amount: 0, meatChoice: []),

  static List<CategoryCard> get menuCategoryCards {
    switch (appFlavor) {
      case Flavor.orderappTest:
        return [
          CategoryCard('SANDWICHES Test', 'Vores sandwiches serveres med tomat, agurk, salat og peberfrugt.'),
          CategoryCard('SALATER Test', 'Serveres med brød.'),
          CategoryCard('OMELETTER Test', 'Serveres med brød og smør.'),
          CategoryCard('PASTA RETTER Test', ''),
          CategoryCard('ALLA CARTE Test', 'Alle kødretter serveres med dagens garniture.'),
          CategoryCard('PIZZA Test', 'Original pizzadej med olivenolie. Alle pizzaer er med tomat og ost.'),
        ];
      case Flavor.ilmolino:
        return [
          CategoryCard('SANDWICHES', 'Vores sandwiches serveres med tomat, agurk, salat og peberfrugt.'),
          CategoryCard('SALATER', 'Serveres med brød.'),
          CategoryCard('OMELETTER', 'Serveres med brød og smør.'),
          CategoryCard('PASTA RETTER', ''),
          CategoryCard('ALLA CARTE', 'Alle kødretter serveres med dagens garniture.'),
          CategoryCard('PIZZA', 'Original pizzadej med olivenolie. Alle pizzaer er med tomat og ost.'),
          CategoryCard('SPECIALITETER', ''),
          CategoryCard('ZUPPA/SUPPE', ''),
          CategoryCard('BØRNE MENU', ''),
          CategoryCard('DESSERTER', ''),
          CategoryCard('KOLDE DRIKKE', ''),
          CategoryCard('VARME DRIKKE', ''),
        ];
      case Flavor.chiangmai:
        return [
          CategoryCard('Thai specialiteter', ''),
          CategoryCard('Supper', ''),
          CategoryCard('Forretter', ''),
          CategoryCard('Kylling Retter', ''),
          CategoryCard('Svinekød Retter', ''),
          CategoryCard('Oksekød Retter', ''),
          CategoryCard('Børnemenu 🧒👧', ''),
          CategoryCard('Alt godt fra havet', ''),
          CategoryCard('Vegetar', ''),
          CategoryCard('And', ''),
          CategoryCard('Stegte ris og nudler', ''),
        ];
      default:
        return [];
    }
  }
}
