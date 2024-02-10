import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:timezone/timezone.dart';
class FlutterLocalNotificationService {
  static late FlutterLocalNotificationsPlugin flutterLocalNotification;
  static late AndroidInitializationSettings androidInitializationSettings;
  // static late DarwinInitializationSettings darwinInitializationSettings;
  static late InitializationSettings initializationSettings;
  static void init(
      {
      // required String descNight,
      required String descMorning}) async {
    flutterLocalNotification = FlutterLocalNotificationsPlugin();
    androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    //  darwinInitializationSettings =
    //     DarwinInitializationSettings(
    //       onDidReceiveLocalNotification:
    //     );
    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    flutterLocalNotification
        .initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse:
    )
        .then((value) {
      showScheduleNotification(
        descMorning: descMorning,
        //  descNight: descNight
      );
    }).catchError((e) {
      log(e.toString());
    });
  }

  static void showScheduleNotification(
      {required String descMorning // , required String descNight
      }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("0", "منارة التوحيد",
            channelDescription: "الادعية",
            importance: Importance.max,
            priority: Priority.high);
    // DarwinNotificationDetails darwinNotificationDetails =
    // const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      // iOS: darwinNotificationDetails
    );
    // TimeOfDay morningTime = const TimeOfDay(hour: 7, minute: 0);
    // TimeOfDay eveningTime = const TimeOfDay(hour: 22, minute: 0);
    List text = [
      "الحمد لله",
      "صلى على النبى",
      "سبحان الله و بحمده",
      "الله أكبر",
      "لا إله إلا الله",
      "أستغفر الله",
      "سبحان الله",
    ];
    int numberOfYear = DateTime.now().day;
    flutterLocalNotification
        .periodicallyShow(
          0,
          text[numberOfYear % text.length],
          descMorning,
          RepeatInterval.daily,
          // _nextInstanceOfTime(morningTime),
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exact,
        )
        .then((value) {})
        .catchError((e) {
      log(e.toString());
    });
    // flutterLocalNotification
    //     .zonedSchedule(
    //       1,
    //       "منارة التوحيد",
    //       descNight,
    //       _nextInstanceOfTime(eveningTime),
    //       notificationDetails,
    //       uiLocalNotificationDateInterpretation:
    //           UILocalNotificationDateInterpretation.absoluteTime,
    //       androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    //     )
    //     .then((value) {})
    //     .catchError((e) {
    //   log(e.toString());
    // });
  }

  // static TZDateTime _nextInstanceOfTime(TimeOfDay timeOfDay) {
  //   TZDateTime now = TZDateTime.now(getLocation("Africa/Cairo"));
  //   TZDateTime scheduleDate = TZDateTime(
  //     getLocation("Africa/Cairo"),
  //     now.year,
  //     now.month,
  //     now.day + 1,
  //     timeOfDay.hour,
  //     timeOfDay.minute,
  //   );
  //   if (scheduleDate.isBefore(now)) {
  //     scheduleDate.add(const Duration(days: 1));
  //   }
  //   return scheduleDate;
  // }

  static void offNotifications() {
    flutterLocalNotification.cancelAll().then((value) {}).catchError((e) {
      log(e.toString());
    });
  }

  static void onNotifications() {
    flutterLocalNotification
        .getActiveNotifications()
        .then((value) {})
        .catchError((e) {
      log(e.toString());
    });
  }
}
