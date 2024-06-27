import 'dart:developer';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:velocity_x/velocity_x.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Notifications {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
    'reminder_notifID',
    'alarm_notifChannel',
    channelDescription: 'Channel for Alarm notification',
    icon: '@mipmap/ic_launcher',
  );

  DarwinNotificationDetails iOSPlatformChannelSpecifics =
      const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  Future<void> setupNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
    await notificationsPlugin.initialize(
      InitializationSettings(
          android: androidInitializationSettings,
          iOS: darwinInitializationSettings),
    );

    if (Platform.isIOS) {
      await notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: false,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      await notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  Future<bool> scheduleReminder({required DateTime? alarmTime, int? id}) async {
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    try {
      if (!alarmTime!.isAfter(DateTime.now())) {
        alarmTime.add(1.days);
      }

      await notificationsPlugin.zonedSchedule(
        id!,
        'Office',
        "alarmInfo.title",
        tz.TZDateTime.from(alarmTime, tz.local),
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.inexact,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  removeAlarm(int id) async {
    await notificationsPlugin.cancel(id);
  }

  getActivetAlarm() async {
    final active = await notificationsPlugin.getActiveNotifications();

    return active;
  }

  getPendingAlarms() async {
    final pending = await notificationsPlugin.pendingNotificationRequests();

    return pending;
  }

  removaAllAlarms() async => await notificationsPlugin.cancelAll();
  //@pragma('vm:entry-point')
}
