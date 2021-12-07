import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel ID',
        'channel name',
        'channel description',
        playSound: true,
        priority: Priority.high,
        importance: Importance.high,
      ),
      iOS: IOSNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          badgeNumber: 1,
          subtitle: "",
          threadIdentifier: ""),
    );
  }

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    //initialize timezone package here
    tz.initializeTimeZones(); //  <----

    await _notifications.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  Future<void> scheduleNotifications() async {
    print("hello world");
    var time = Time(7, 0, 0);
    await _notifications.periodicallyShow(
      0,
      "CryptoByte",
      "Don't forget to check the prices!",
      RepeatInterval.everyMinute,
      await _notificationDetails(),
    );
    print("hello world");
  }

  static tz.TZDateTime _scheduleHourly(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    // ignore: avoid_print
    print(tz.local);

    return scheduleDate.isBefore(now)
        ? scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }

  static tz.TZDateTime _scheduleDaily(Time time, List days) {
    tz.TZDateTime scheduleDate = _scheduleHourly(Time(7));
    while (!days.contains(scheduleDate.weekday)) {
      scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }
}
