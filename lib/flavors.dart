import 'package:flutter/material.dart';

import 'model/CategoryCard.dart';
import 'model/MenuItem.dart';

enum Flavor {
  ilmolino,
  orderappTest,
}

class F {
  static Flavor? appFlavor;
  static String get appTitle {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'IL MOLINO';
      case Flavor.orderappTest:
        return 'Orderapptest';
      default:
        return 'title';
    }
  }

  static String get companyWebsite {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'https://ilmolinolyngby.dk';
      case Flavor.orderappTest:
        return 'https://orderapptest.dk';
      default:
        return 'companyWebsite';
    }
  }

  static String get companyPhone {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return '+45 45 88 51 10';
      case Flavor.orderappTest:
        return '+45 12 34 56 78';
      default:
        return 'companyPhone';
    }
  }

  static String get companyAddress {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'Gammel Lundtoftevej 14, 2800 Kongens Lyngby';
      case Flavor.orderappTest:
        return 'test addresse og noget mere';
      default:
        return 'companyAddress';
    }
  }

  static String get privacyPolicyURL {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'https://www.termsfeed.com/live/yourPolicy';
      case Flavor.orderappTest:
        return 'https://www.termsfeed.com/live/yourPolicy';
      default:
        return 'privacyPolicyURL';
    }
  }

  static MaterialColor get appPrimaryColor {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return Colors.brown;
      case Flavor.orderappTest:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  static MaterialColor get appSecondaryColor {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return Colors.yellow;
      case Flavor.orderappTest:
        return Colors.lightGreen;
      default:
        return Colors.lightBlue;
    }
  }

  static String get appIconPathLight {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'assets/ilmolino/icons/iconlight.png';
      case Flavor.orderappTest:
        return 'assets/orderapptest/icons/iconlight.png';
      default:
        return '';
    }
  }

  static String get appIconPathDark {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'assets/ilmolino/icons/icondark.png';
      case Flavor.orderappTest:
        return 'assets/orderapptest/icons/icondark.png';
      default:
        return '';
    }
  }

  static String get firestoreCollection {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'application/ilmolino';
      case Flavor.orderappTest:
        return 'application/orderapptest';
      default:
        return 'testing/';
    }
  }

  static String get baseURL {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return 'https://fcm.googleapis.com';
      case Flavor.orderappTest:
        return 'https://fcm.googleapis.com';
      default:
        return 'https://fcm.googleapis.com';
    }
  }

  static String get serverToken {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return '';
      case Flavor.orderappTest:
        return '';
      default:
        return '';
    }
  }

  static List<List<MenuItem>> get allMenus {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return [
          //SANDWICHES
          [
            MenuItem(1, 'CLUB SANDWICH', 'Med kylling, bacon og pesto', 75, '', 0, meatChoice: []),
            MenuItem(2, 'Serano SANDWICH', 'Med frisk mozzarella eller gorgonzola, serano og pesto', 75, '', 0, meatChoice: []),
            MenuItem(3, 'LAKSE SANDWICH', 'Med røget laks og hjemmelavet dilddressing', 75, 'assets/ilmolino/menu/3.jpg', 0, meatChoice: []),
            MenuItem(4, 'BACON AVOKADO', 'Med luksus bacon, frisk avokado og pesto', 75, '', 0, meatChoice: []),
            MenuItem(5, 'TUNO', 'Med hjemmelavet tunmousse og pesto', 75, 'assets/ilmolino/menu/5.jpg', 0, meatChoice: []),
          ],

//SALATER
          [
            MenuItem(
                6, 'INSALATA CAPRESE', 'Med frisk mozzarella, frisk basilikum, stilk tomat og hjemmelavet pesto', 89, 'assets/ilmolino/menu/6.jpg', 0,
                meatChoice: []),
            MenuItem(7, 'KYLLING & BACON', 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto', 89, '', 0,
                meatChoice: []),
            MenuItem(8, 'HJEMMELAVET TUNCREME', 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto', 89,
                'assets/ilmolino/menu/8.jpg', 0,
                meatChoice: []),
            MenuItem(9, 'KYLLING PASTA SALAT', 'Serveres med penne, peberfrugt, semi-dried tomater, rucola, oliven og pesto', 89, '', 0,
                meatChoice: []),
          ],

//OMELETTER
          [
            MenuItem(10, 'KYLLING OG BACON', 'Med kylling og bacon og cheddarost', 85, '', 0, meatChoice: []),
            MenuItem(11, 'VEGETAR OMELET', 'Med grillede grøntsager, champignon og cheddarost', 85, '', 0, meatChoice: []),
            MenuItem(12, 'HUSETS OMELET', 'Med løg, bacon, cherry tomater, olivenolie og cheddarost', 85, 'assets/ilmolino/menu/12.jpg', 0,
                meatChoice: []),
          ],

//PASTA RETTER
          [
            MenuItem(13, 'LASAGNE', 'Med kødsauce', 89, '', 0, meatChoice: []),
            MenuItem(14, 'SPAGHETTI BOLOGNESE', 'Spaghetti med kødsauce', 89, 'assets/ilmolino/menu/14.jpg', 0, meatChoice: []),
            MenuItem(15, 'SPAGHETTI ALLA CARBONARE', 'Med bacon, æg, flødesauce og frisk parmesan', 89, '', 0, meatChoice: []),
            MenuItem(16, 'PASTA PESTO', 'Penne med kylling, hjemmelavet pesto og frisk grana', 89, 'assets/ilmolino/menu/16.jpg', 0, meatChoice: []),
            MenuItem(17, 'SPAGHETTI CON CARNE', 'Med bøfstrimler, løg, champignon, pomodore og frisk grana', 95, '', 0, meatChoice: []),
            MenuItem(18, 'SPAGHETTI ALLA GORGONZOLA', 'Med gorgonzola, serano og frisk grana', 95, '', 0, meatChoice: []),
            MenuItem(19, 'PENNE ALLA LAKS', 'Med røget laks og pomodore, pesto og frisk grana', 95, '', 0, meatChoice: []),
            MenuItem(20, 'TORTELLINI PANNA PROSCIUTTO', 'Med skinke, løg, champignon, pomodore og ost', 95, '', 0, meatChoice: []),
            MenuItem(21, 'PENNE VEGETALI', 'Med grillede grøntsager, løg, champignon, pomodore og frisk grana', 95, '', 0, meatChoice: []),
          ],

          //ALLA CARTE
          [
            MenuItem(22, 'BØF CLASSICA', 'Mør og saftig oksefilet med bearnaisesauce og italiensk rosmarin kartofler', 159, '', 0, meatChoice: []),
            MenuItem(23, 'HVIDLØGS BØF', 'Mør og lækker oksefilet marineret med hvidløg, creme fraiche og kartofler', 159, '', 0, meatChoice: []),
            MenuItem(24, 'HUSETS BØF', 'Mør og saftig oksefilet med hjemmelavet whisky sauce og italienske rosmarin kartofler', 169, '', 0,
                meatChoice: []),
            MenuItem(25, 'TARTUFO', 'Mør og saftig oksefilet med hjemmelavet trøffel sauce og italienske rosmarin kartofler', 169, '', 0,
                meatChoice: []),
          ],

          //PIZZA
          [
            MenuItem(30, 'MARGHERITA', 'Tomat og ost', 65, '', 0, meatChoice: []),
            MenuItem(31, 'CAPRICCIOSA', 'Skinke og champignon', 75, '', 0, meatChoice: []),
            MenuItem(32, 'CACCIATORE', 'Pepperoni, oliven og friske tomater', 75, '', 0, meatChoice: []),
            MenuItem(33, 'CALZONE (INDBAGT)', 'Med skinke og champignon', 75, '', 0, meatChoice: []),
            MenuItem(34, 'HAWAII', 'Skinke og ananas', 75, '', 0, meatChoice: []),
            MenuItem(35, 'NAPOLI', 'Ansjoser, oliven, løg, kapers og hvidløg', 85, '', 0, meatChoice: []),
            MenuItem(36, 'POLO', 'Med kylling, frisk tomat og rucola', 85, '', 0, meatChoice: []),
            MenuItem(37, 'ESTATE', 'Med serano , rucola, frisk grana og pesto', 85, '', 0, meatChoice: []),
            MenuItem(38, 'PEPINO', 'Med italiensk salami, rucola, frisk grana og pesto', 85, '', 0, meatChoice: []),
            MenuItem(39, 'PERIMAVERA', 'Med frisk mozzarella, frisk tomat, basilicum og pesto', 85, '', 0, meatChoice: []),
            MenuItem(40, 'PARMA', 'Med gorgonzola, champignon og serano', 85, '', 0, meatChoice: []),
            MenuItem(41, 'MONZESE', 'Med spinat, gorgonzola, grana, chili og hvidløg', 85, '', 0, meatChoice: []),
            MenuItem(42, 'SPINACI', 'Med røget laks, spinat, rejer og hvidløg', 89, '', 0, meatChoice: []),
            MenuItem(43, 'PATATA', 'Med kartofler, frisk mozzarella, frisk rosmarin og oliven', 89, 'assets/ilmolino/menu/43.jpg', 0, meatChoice: []),
            MenuItem(44, 'CONTADINA', 'Med frisk mozzarella, kylling, stegt bacon og spinat', 89, '', 0, meatChoice: []),
            MenuItem(45, 'MONDENA', 'Med frisk mozzarella, rucola, cherry tomater og frisk grana', 89, 'assets/ilmolino/menu/45.jpg', 0,
                meatChoice: []),
            MenuItem(46, 'HUSETS SPECIAL', 'Med italiensk bøfstrimler, løg, peberfrugt, champignon og sød sennep', 89, '', 0, meatChoice: []),
            MenuItem(47, 'SICILIA', 'Med frisk avokado, luksus bacon og cherry tomater m/u pesto', 89, 'assets/ilmolino/menu/47.jpg', 0,
                meatChoice: []),
            MenuItem(48, 'DELLA CASA', 'Oksekød, bacon, tomater, løg, peberfrugt og kapers', 89, '', 0, meatChoice: []),
          ],

          //SPECIALITETER
          [
            MenuItem(50, 'CAFE BURGER', '200 gram hakkebøf med cheddarost i økologisk bolle og italiensk rosmarin kartofler', 119,
                'assets/ilmolino/menu/50.jpg', 0,
                meatChoice: []),
            MenuItem(51, 'CHILLI CON CARNE', 'Tilberedt med hjemmelavet salsa, nachos, brød og creme fraiche', 109, 'assets/ilmolino/menu/51.jpg', 0,
                meatChoice: []),
            MenuItem(52, 'BURRITO', 'Ovnbagte meltortillas med bønner, oksekød, tortilla chips og salat', 109, '', 0, meatChoice: []),
            MenuItem(53, 'NACHOS', 'Tortila chips med kylling, ost og salsa eller guacamole', 89, '', 0, meatChoice: []),
          ],

          //ZUPPA/SUPPE
          [
            MenuItem(60, 'CREMA DI POMODORO', 'Tomat suppe med brød', 59, '', 0, meatChoice: []),
            MenuItem(61, 'ZUPPA DI VERDURE', 'Grøntsags suppe med brød', 59, '', 0, meatChoice: []),
          ],

          //BØRNE MENU
          [
            MenuItem(62, 'SPAGHETTI BOLOGNESE', 'Spaghetti med kødsauce', 59, '', 0, meatChoice: []),
            MenuItem(63, 'PIZZA BAMBINO', 'Med tomat, ost, skinke og pølser', 59, '', 0, meatChoice: []),
            MenuItem(64, 'LASAGNE BAMBINO', 'Lasagne med kødsauce', 59, '', 0, meatChoice: []),
          ],

          //DESSERTER
          [
            MenuItem(70, 'CRESPELE CON GELATO', 'Pandekage med italiensk is og chokoladesauce', 59, '', 0, meatChoice: []),
            MenuItem(71, 'GELATO DELLA CASA', 'Husets is med chokolade sauce', 59, '', 0, meatChoice: []),
            MenuItem(72, 'TORTA VARM DRIK', 'Med italiensk kage', 59, '', 0, meatChoice: []),
            MenuItem(73, 'DESSERT PIZZA', '', 75, '', 0, meatChoice: []),
          ],

          //KOLDE DRIKKE
          [
            MenuItem(90, 'Cola, Cola Zero, Sprite, Fanta', '', 27, '', 0, meatChoice: []),
            MenuItem(91, 'Økologisk hyldeblomst eller solbær', '', 29, '', 0, meatChoice: []),
            MenuItem(92, 'San Pellegrino med brus', '0,5 l.', 35, '', 0, meatChoice: []),
            MenuItem(93, 'Limonade', '0,5 l.', 35, '', 0, meatChoice: []),
            MenuItem(94, 'Aranciate Rossa', 'Blodappelsin 0,5 l.', 35, '', 0, meatChoice: []),
            MenuItem(95, 'Italiensk øl', 'Peroni', 35, '', 0, meatChoice: []),
            MenuItem(96, 'Tuborg profil', '', 30, '', 0, meatChoice: []),
            MenuItem(97, 'La Rossa Moretti', '', 29, '', 0, meatChoice: []),
            MenuItem(98, 'Italiensk kildevand', '', 22, '', 0, meatChoice: []),
          ],

          //VARME DRIKKE
          [
            MenuItem(100, 'Kaffe', '', 24, '', 0, meatChoice: []),
            MenuItem(101, 'Espresso', '', 24, '', 0, meatChoice: []),
            MenuItem(102, 'Dobbelt espresso', '', 32, '', 0, meatChoice: []),
            MenuItem(103, 'Cappuccino', '', 30, '', 0, meatChoice: []),
            MenuItem(104, 'Caffe latte', '', 35, '', 0, meatChoice: []),
            MenuItem(105, 'Café au lait', '', 35, '', 0, meatChoice: []),
            MenuItem(106, 'Chai latte', '', 35, '', 0, meatChoice: []),
          ],
        ];
      case Flavor.orderappTest:
        return [
          //SANDWICHES
          [
            MenuItem(1, 'CLUB SANDWICH Test', 'Med kylling, bacon og pesto', 75, '', 0, meatChoice: []),
            MenuItem(2, 'Serano SANDWICH Test', 'Med frisk mozzarella eller gorgonzola, serano og pesto', 75, '', 0, meatChoice: []),
            MenuItem(3, 'LAKSE SANDWICH Test', 'Med røget laks og hjemmelavet dilddressing', 75, 'assets/orderapptest/menu/1.jpg', 0, meatChoice: []),
            MenuItem(4, 'BACON AVOKADO Test', 'Med luksus bacon, frisk avokado og pesto', 75, '', 0, meatChoice: []),
            MenuItem(5, 'TUNO Test', 'Med hjemmelavet tunmousse og pesto', 75, 'assets/orderapptest/menu/1.jpg', 0, meatChoice: []),
          ],

//SALATER
          [
            MenuItem(6, 'INSALATA CAPRESE Test', 'Med frisk mozzarella, frisk basilikum, stilk tomat og hjemmelavet pesto', 89,
                'assets/orderapptest/menu/1.jpg', 0,
                meatChoice: []),
            MenuItem(7, 'KYLLING & BACON Test', 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto', 89, '', 0,
                meatChoice: []),
            MenuItem(8, 'HJEMMELAVET TUNCREME Test', 'Serveres med tomat, agurk, løg, peberfrugt, semi-dried tomater, salatmix og pesto', 89,
                'assets/orderapptest/menu/1.jpg', 0,
                meatChoice: []),
            MenuItem(9, 'KYLLING PASTA SALAT Test', 'Serveres med penne, peberfrugt, semi-dried tomater, rucola, oliven og pesto', 89, '', 0,
                meatChoice: []),
          ],

//OMELETTER
          [
            MenuItem(10, 'KYLLING OG BACON Test', 'Med kylling og bacon og cheddarost', 85, '', 0, meatChoice: []),
            MenuItem(11, 'VEGETAR OMELET Test', 'Med grillede grøntsager, champignon og cheddarost', 85, '', 0, meatChoice: []),
            MenuItem(12, 'HUSETS OMELET Test', 'Med løg, bacon, cherry tomater, olivenolie og cheddarost', 85, 'assets/orderapptest/menu/1.jpg', 0,
                meatChoice: []),
          ],

//PASTA RETTER
          [
            MenuItem(13, 'LASAGNE Test', 'Med kødsauce', 89, '', 0, meatChoice: []),
            MenuItem(14, 'SPAGHETTI BOLOGNESE Test', 'Spaghetti med kødsauce', 89, 'assets/orderapptest/menu/1.jpg', 0, meatChoice: []),
            MenuItem(15, 'SPAGHETTI ALLA CARBONARE Test', 'Med bacon, æg, flødesauce og frisk parmesan', 89, '', 0, meatChoice: []),
            MenuItem(16, 'PASTA PESTO Test', 'Penne med kylling, hjemmelavet pesto og frisk grana', 89, 'assets/orderapptest/menu/1.jpg', 0,
                meatChoice: []),
            MenuItem(17, 'SPAGHETTI CON CARNE Test', 'Med bøfstrimler, løg, champignon, pomodore og frisk grana', 95, '', 0, meatChoice: []),
            MenuItem(18, 'SPAGHETTI ALLA GORGONZOLA Test', 'Med gorgonzola, serano og frisk grana', 95, '', 0, meatChoice: []),
            MenuItem(19, 'PENNE ALLA LAKS Test', 'Med røget laks og pomodore, pesto og frisk grana', 95, '', 0, meatChoice: []),
            MenuItem(20, 'TORTELLINI PANNA PROSCIUTTO Test', 'Med skinke, løg, champignon, pomodore og ost', 95, '', 0, meatChoice: []),
            MenuItem(21, 'PENNE VEGETALI Test', 'Med grillede grøntsager, løg, champignon, pomodore og frisk grana', 95, '', 0, meatChoice: []),
          ],

          //ALLA CARTE
          [
            MenuItem(22, 'BØF CLASSICA Test', 'Mør og saftig oksefilet med bearnaisesauce og italiensk rosmarin kartofler', 159, '', 0,
                meatChoice: []),
            MenuItem(23, 'HVIDLØGS BØF Test', 'Mør og lækker oksefilet marineret med hvidløg, creme fraiche og kartofler', 159, '', 0,
                meatChoice: []),
            MenuItem(24, 'HUSETS BØF Test', 'Mør og saftig oksefilet med hjemmelavet whisky sauce og italienske rosmarin kartofler', 169, '', 0,
                meatChoice: []),
            MenuItem(25, 'TARTUFO Test', 'Mør og saftig oksefilet med hjemmelavet trøffel sauce og italienske rosmarin kartofler', 169, '', 0,
                meatChoice: []),
          ],

          //PIZZA
          [
            MenuItem(30, 'MARGHERITA Test', 'Tomat og ost', 65, '', 0, meatChoice: []),
            MenuItem(31, 'CAPRICCIOSA Test', 'Skinke og champignon', 75, '', 0, meatChoice: []),
            MenuItem(32, 'CACCIATORE Test', 'Pepperoni, oliven og friske tomater', 75, '', 0, meatChoice: []),
            MenuItem(33, 'CALZONE (INDBAGT) Test', 'Med skinke og champignon', 75, '', 0, meatChoice: []),
            MenuItem(34, 'HAWAII Test', 'Skinke og ananas', 75, '', 0, meatChoice: []),
            MenuItem(35, 'NAPOLI Test', 'Ansjoser, oliven, løg, kapers og hvidløg', 85, '', 0, meatChoice: []),
            MenuItem(36, 'POLO Test', 'Med kylling, frisk tomat og rucola', 85, '', 0, meatChoice: []),
            MenuItem(37, 'ESTATE Test', 'Med serano , rucola, frisk grana og pesto', 85, '', 0, meatChoice: []),
            MenuItem(38, 'PEPINO Test', 'Med italiensk salami, rucola, frisk grana og pesto', 85, '', 0, meatChoice: []),
            MenuItem(39, 'PERIMAVERA Test', 'Med frisk mozzarella, frisk tomat, basilicum og pesto', 85, '', 0, meatChoice: []),
            MenuItem(40, 'PARMA Test', 'Med gorgonzola, champignon og serano', 85, '', 0, meatChoice: []),
            MenuItem(41, 'MONZESE Test', 'Med spinat, gorgonzola, grana, chili og hvidløg', 85, '', 0, meatChoice: []),
            MenuItem(42, 'SPINACI Test', 'Med røget laks, spinat, rejer og hvidløg', 89, '', 0, meatChoice: []),
            MenuItem(43, 'PATATA Test', 'Med kartofler, frisk mozzarella, frisk rosmarin og oliven', 89, 'assets/orderapptest/menu/1.jpg', 0,
                meatChoice: []),
            MenuItem(44, 'CONTADINA Test', 'Med frisk mozzarella, kylling, stegt bacon og spinat', 89, '', 0, meatChoice: []),
            MenuItem(45, 'MONDENA Test', 'Med frisk mozzarella, rucola, cherry tomater og frisk grana', 89, 'assets/orderapptest/menu/1.jpg', 0,
                meatChoice: []),
            MenuItem(46, 'HUSETS SPECIAL Test', 'Med italiensk bøfstrimler, løg, peberfrugt, champignon og sød sennep', 89, '', 0, meatChoice: []),
            MenuItem(47, 'SICILIA Test', 'Med frisk avokado, luksus bacon og cherry tomater m/u pesto', 89, 'assets/orderapptest/menu/1.jpg', 0,
                meatChoice: []),
            MenuItem(48, 'DELLA CASA Test', 'Oksekød, bacon, tomater, løg, peberfrugt og kapers', 89, '', 0, meatChoice: []),
          ],
        ];
      default:
        return [];
    }
  }

  static List<CategoryCard> get menuCategoryCards {
    switch (appFlavor) {
      case Flavor.ilmolino:
        return [
          CategoryCard('SANDWICHES', 'Vores sandwiches serveres med tomat, agurk, salat og peberfrugt.', false),
          CategoryCard('SALATER', 'Serveres med brød.', false),
          CategoryCard('OMELETTER', 'Serveres med brød og smør.', false),
          CategoryCard('PASTA RETTER', '', false),
          CategoryCard('ALLA CARTE', 'Alle kødretter serveres med dagens garniture.', false),
          CategoryCard('PIZZA', 'Original pizzadej med olivenolie. Alle pizzaer er med tomat og ost.', false),
          CategoryCard('SPECIALITETER', '', false),
          CategoryCard('ZUPPA/SUPPE', '', false),
          CategoryCard('BØRNE MENU', '', false),
          CategoryCard('DESSERTER', '', false),
          CategoryCard('KOLDE DRIKKE', '', false),
          CategoryCard('VARME DRIKKE', '', false),
        ];
      case Flavor.orderappTest:
        return [
          CategoryCard('SANDWICHES Test', 'Vores sandwiches serveres med tomat, agurk, salat og peberfrugt.', false),
          CategoryCard('SALATER Test', 'Serveres med brød.', false),
          CategoryCard('OMELETTER Test', 'Serveres med brød og smør.', false),
          CategoryCard('PASTA RETTER Test', '', false),
          CategoryCard('ALLA CARTE Test', 'Alle kødretter serveres med dagens garniture.', false),
          CategoryCard('PIZZA Test', 'Original pizzadej med olivenolie. Alle pizzaer er med tomat og ost.', false),
        ];
      default:
        return [];
    }
  }
}
