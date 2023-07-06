import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
   AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings=InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> mostrarNotification(int id, String title, String body) async {
  var dateTime = DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day, 17, 14, 0);
  tz.initializeTimeZones();
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(dateTime, tz.local),
    NotificationDetails(
      android: AndroidNotificationDetails(
          id.toString(),
          'Go To Bed',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@mipmap/ic_launcher'
      ),
    ),
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );

}

