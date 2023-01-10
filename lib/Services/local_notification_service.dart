// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //ios permission

  iosPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  //macos permission
  macPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  //android permission
  androidPermission() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  Future<void> init() async {
    if (Platform.isAndroid) {
      androidPermission();
    }
    if (Platform.isIOS) {
      iosPermission();
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
          'demoCategory',
          // actions: [
          //   DarwinNotificationAction.text('', "Cancel",
          //       buttonTitle: '',
          //       options: {
          //         DarwinNotificationActionOption.destructive,
          //         DarwinNotificationActionOption.foreground,
          //       })
          // ],
          // options: <DarwinNotificationCategoryOption>{
          //   DarwinNotificationCategoryOption.customDismissAction,
          // },
        )
      ],
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    tz.initializeTimeZones();
    await NotificationService()
        .flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        onDidReceiveNotificationResponse: notificationTap);
  }

  // Android notification details

  static const AndroidNotificationDetails _androidChannelSound =
      AndroidNotificationDetails(
    '1',
    'Agent League',
    channelDescription: 'This is for Notification',
    playSound: true,
    //sound: RawResourceAndroidNotificationSound('azan1'),
    // actions: <AndroidNotificationAction>[
    //   AndroidNotificationAction('2', 'Cancel'),
    // ],
    audioAttributesUsage: AudioAttributesUsage.notificationRingtone,
    visibility: NotificationVisibility.public,
    enableVibration: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  // Iso notification details
  static const DarwinNotificationDetails _iosChannelSound =
      DarwinNotificationDetails(
    presentAlert: true,
    presentSound: false,
    presentBadge: true,
    interruptionLevel: InterruptionLevel.critical,
  );

  final NotificationDetails _channelSound = const NotificationDetails(
    android: _androidChannelSound,
    iOS: _iosChannelSound,
  );

  // Notification data
  Future<void> showNotifications(
    int notificationId,
    String notificationTitle,
    String notificationBody,
    String? payload,
  ) async {
    await flutterLocalNotificationsPlugin.show(
        notificationId, notificationTitle, notificationBody, _channelSound,
        payload: payload);
  }

  Future<void> scheduleNotification(id, title, description, dateTime,
      NotificationDetails notificationDetails) async {
    final scheduledDate = tz.TZDateTime.from(dateTime, tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      description,
      scheduledDate,
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

void notificationTap(NotificationResponse notificationResponse) async {
  // handle action
}

@pragma('vm:entry-point')
void notificationTapBackground(
    NotificationResponse notificationResponse) async {
  // handle action
}
