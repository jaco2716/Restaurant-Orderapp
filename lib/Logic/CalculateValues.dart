// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurantorderapp/model/ApplicationData.dart';

import '../flavors.dart';
import '../model/MenuItem.dart';

class CalculateValues {
  String dateStringFromMili(String orderDate) {
    List<String> dateTimeList = DateTime.fromMillisecondsSinceEpoch(int.parse(orderDate)).toString().split(' ');
    List<String> dateList = dateTimeList[0].split('-');
    List<String> timeList = dateTimeList[1].split(':');
    String date = '${dateList[2]}/${dateList[1]}/${dateList[0]}';
    String time = '${timeList[0]}:${timeList[1]}';

    return '$time  $date';
  }

  int totalPriceFromOrder(List<MenuItem> items) {
    int total = 0;
    items.forEach((element) {
      int meatChoiceTotal = 0;
      if (element.meatChoice.length != 0) {
        element.meatChoice.forEach((meat) {
          meatChoiceTotal += meat.price * meat.amount;
        });
      }
      total += element.price * element.amount + meatChoiceTotal;
    });
    return total;
  }

  Future<bool> checkIfWithinOpenHours(DateTime currentDate) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      // currentDate = DateTime(2020, 9, 22, 2, 01);
      double currentTimeDouble = (currentDate.hour * 100 + currentDate.minute.toDouble()) / 100;

      DocumentSnapshot applicationDataSnapshot = await _firestore.doc('${F.firestoreCollection}').get();
      ApplicationData appData = ApplicationData.fromJson(applicationDataSnapshot.data() as Map<String, dynamic>);

      List<double> openTimes = appData.openingHours.map((e) => e / 100 as double).toList();
      List<double> closeTimes = appData.closingHours.map((e) => e / 100 as double).toList();

      // openTimes = [11.0, 11.0, 11.0, 11.0, 11.0, 11.0, 11.0];
      // closeTimes = [4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 11.0];

      // print('open: ${openTimes[currentDate.weekday - 1]} - ${closeTimes[currentDate.weekday - 1]}');
      // print('now: $currentTimeDouble');

      // print('Yesterday open: ${openTimes[(currentDate.weekday - 2) % 7]} - ${closeTimes[(currentDate.weekday - 2) % 7]}');

      if (openTimes[(currentDate.weekday - 2) % 7] > closeTimes[(currentDate.weekday - 2) % 7] &&
          (currentTimeDouble < closeTimes[(currentDate.weekday - 2) % 7])) {
        print('restaurant open after midnight. Now: $currentTimeDouble Close: ${closeTimes[(currentDate.weekday - 2) % 7]}');
        return true;
      }

      if ((currentTimeDouble < openTimes[currentDate.weekday - 1] || currentTimeDouble > closeTimes[currentDate.weekday - 1])) {
        if (openTimes[currentDate.weekday - 1] < closeTimes[currentDate.weekday - 1]) {
          print(
              'restaurant closed normal. Now: $currentTimeDouble. Open: ${openTimes[currentDate.weekday - 1]} - ${closeTimes[currentDate.weekday - 1]}');
          return false;
        } else if (currentTimeDouble > openTimes[currentDate.weekday - 1]) {
          print(
              'restaurant open to midnight. Now: $currentTimeDouble. Open: ${openTimes[currentDate.weekday - 1]} - ${closeTimes[currentDate.weekday - 1]}');
          return true;
        } else {
          print(
              'restaurant closed before open rest of day. Now: $currentTimeDouble. Open: ${openTimes[currentDate.weekday - 1]} - ${closeTimes[currentDate.weekday - 1]}');
          return false;
        }
      } else {
        print(
            'restaurant open normal. Now: $currentTimeDouble. Open: ${openTimes[currentDate.weekday - 1]} - ${closeTimes[currentDate.weekday - 1]}');
        return true;
      }
    } catch (error) {
      print('date Error');
      print(error.toString());
      return false;
    }
  }

  Future<List<double>> getTodaysOpenCloseHour(DateTime currentDate) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    DocumentSnapshot applicationDataSnapshot = await _firestore.doc('${F.firestoreCollection}').get();
    ApplicationData appData = ApplicationData.fromJson(applicationDataSnapshot.data() as Map<String, dynamic>);
    double currentTimeDouble = (currentDate.hour * 100 + currentDate.minute.toDouble()) / 100;

    List<double> openTimes = appData.openingHours.map((e) => e / 100 as double).toList();
    List<double> closeTimes = appData.closingHours.map((e) => e / 100 as double).toList();

    List<double> openCloseHour = [openTimes[currentDate.weekday - 1], closeTimes[currentDate.weekday - 1]];

    if (openTimes[(currentDate.weekday - 2) % 7] > closeTimes[(currentDate.weekday - 2) % 7] &&
        (currentTimeDouble < closeTimes[(currentDate.weekday - 2) % 7])) {
      openCloseHour = [00, closeTimes[(currentDate.weekday - 2) % 7]];
    }

    print('openCloseHour: $openCloseHour');
    return openCloseHour;
  }
}
