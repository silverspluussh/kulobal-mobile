// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// FlutterLocalNotificationsPlugin notificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// final FirebaseMessaging messaging = FirebaseMessaging.instance;

// AndroidNotificationChannel? channel;

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
//     StreamController<ReceivedNotification>.broadcast();

// final StreamController<String?> selectNotificationStream =
//     StreamController<String?>.broadcast();

// AndroidInitializationSettings initializationSettings =
//     const AndroidInitializationSettings('@mipmap/ic_launcher');

// class Notifs {
//   saveDeviceToken() async {
//     try {
//       String fcmToken = await messaging.getToken() ?? "";
//       // prefs.setString("token", fcmToken);

//       Map? oldToken = {};
//       String oT = oldToken.isNotEmpty ? oldToken["data"]["device_token"] : "";
//       bool status = false;

//       if (fcmToken.isNotEmpty) {
//         if (oT.isNotEmpty) {
//           if (oT.trim() != fcmToken.trim()) {
//             // status = await updateToken(
//             //     device: Platform.operatingSystem, token: fcmToken);
//             return status;
//           }
//         } else {
//           // status = await saveToken(
//           //     device: Platform.operatingSystem, token: fcmToken);
//           return status;
//         }
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   requestFirebasePermissions() async {
//     try {
//       await messaging.requestPermission(
//           alert: true,
//           announcement: false,
//           badge: true,
//           carPlay: false,
//           criticalAlert: false,
//           provisional: false,
//           sound: true);
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   Future<void> requestPermissions() async {
//     try {
//       if (Platform.isIOS) {
//         await notificationsPlugin
//             .resolvePlatformSpecificImplementation<
//                 IOSFlutterLocalNotificationsPlugin>()
//             ?.requestPermissions(
//               alert: true,
//               badge: true,
//               sound: true,
//             );
//       } else if (Platform.isAndroid) {
//         final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//             notificationsPlugin.resolvePlatformSpecificImplementation<
//                 AndroidFlutterLocalNotificationsPlugin>();

//         await androidImplementation?.requestNotificationsPermission();
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }

// Future initFirebase() async {
//   if (!kIsWeb) {
//     await Notifs().requestPermissions();
//     await Notifs().requestFirebasePermissions();
//     await Notifs().saveDeviceToken();
//   }
// }

// Future<void> showSMS(RemoteMessage message) async {
//   BigTextStyleInformation bigtext = BigTextStyleInformation(
//       message.notification?.body ?? "",
//       contentTitle: message.notification?.title,
//       htmlFormatBigText: true);
//   await notificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title,
//       message.notification?.body,
//       NotificationDetails(
//           android: AndroidNotificationDetails(
//         "simplyID",
//         "simplychannel",
//         fullScreenIntent: true,
//         playSound: true,
//         icon: '@mipmap/ic_launcher',
//         styleInformation: bigtext,
//         priority: Priority.high,
//         importance: Importance.max,
//       )));
// }

// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }

// void notificationTapBackground(NotificationResponse notificationResponse) {
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }

// class ReceivedNotification {
//   ReceivedNotification(
//       {required this.id,
//       required this.title,
//       required this.body,
//       required this.payload});

//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }
