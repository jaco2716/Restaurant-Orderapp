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
      if (element.meatChoice != null) {
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
      //currentDate = DateTime(2020, 9, 25, 20, 31);//await NTP.now();
      //currentDate = await NTP.now();
      //print('Current Date: $currentDate');

      DocumentSnapshot applicationDataSnapshot = await _firestore.doc('${F.firestoreCollection}').get();
      ApplicationData appData = ApplicationData.fromJson(applicationDataSnapshot.data() as Map<String, dynamic>);

      double currentTimeDouble = currentDate.hour + currentDate.minute / 60.0;

      double mondayOpenTime = appData.openingHours[0];
      double tuesdayOpenTime = appData.openingHours[1];
      double wednesdayOpenTime = appData.openingHours[2];
      double thursdayOpenTime = appData.openingHours[3];
      double fridayOpenTime = appData.openingHours[4];
      double saturdayOpenTime = appData.openingHours[5];
      double sundayOpenTime = appData.openingHours[6];

      double mondayCloseTime = appData.closingHours[0];
      double tuesdayCloseTime = appData.closingHours[1];
      double wednesdayCloseTime = appData.closingHours[2];
      double thursdayCloseTime = appData.closingHours[3];
      double fridayCloseTime = appData.closingHours[4];
      double saturdayCloseTime = appData.closingHours[5];
      double sundayCloseTime = appData.closingHours[6];

      if ((currentDate.weekday == DateTime.monday && (currentTimeDouble < mondayOpenTime || currentTimeDouble > mondayCloseTime)) ||
          (currentDate.weekday == DateTime.tuesday && (currentTimeDouble < tuesdayOpenTime || currentTimeDouble > tuesdayCloseTime)) ||
          (currentDate.weekday == DateTime.wednesday && (currentTimeDouble < wednesdayOpenTime || currentTimeDouble > wednesdayCloseTime)) ||
          (currentDate.weekday == DateTime.thursday && (currentTimeDouble < thursdayOpenTime || currentTimeDouble > thursdayCloseTime)) ||
          (currentDate.weekday == DateTime.friday && (currentTimeDouble < fridayOpenTime || currentTimeDouble > fridayCloseTime)) ||
          (currentDate.weekday == DateTime.saturday && (currentTimeDouble < saturdayOpenTime || currentTimeDouble > saturdayCloseTime)) ||
          (currentDate.weekday == DateTime.sunday && (currentTimeDouble < sundayOpenTime || currentTimeDouble > sundayCloseTime))) {
        print('restaurant closed');
        return false;
      } else {
        print('restaurant open');
        return true;
      }
    } catch (error) {
      print('date Error');
      print(error.toString());
      return false;
    }
  }
}

// if (currentDate.weekday == DateTime.sunday ||
//     (currentDate.weekday == DateTime.monday &&
//         (currentTimeDouble < mondayOpenTime ||
//             currentTimeDouble > weekCloseTime)) ||
//     ((currentDate.weekday != DateTime.sunday &&
//             currentDate.weekday != DateTime.sunday) &&
//         (currentTimeDouble < weekOpenTime ||
//             currentTimeDouble > weekCloseTime)))
