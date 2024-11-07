import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const List<Map<String, dynamic>> _notificationChannels = [
    {
      "id": "alert_notification",
      "name": "Alert Notification",
      "description": 'Notification Channel for Alert',
      "groupId": 'early_warning_system',
      "sound": "alarm_alert"
    },
    {
      "id": "danger_notification",
      "name": "Danger Notification",
      "description": 'Notification Channel for Alert',
      "groupId": 'early_warning_system',
      "sound": "alarm_danger"
    },
  ];

  static const List<Map<String, dynamic>> _notificationGroups = [
    {"id": "early_warning_system", "name": "Early Warning System"},
  ];

  static int _notificationId = 0;

  int get id => _notificationId;

  static Future<void> initialize() async {
    const androidInitialize = AndroidInitializationSettings('mipmap/app_icon');
    const iOsInitialize = DarwinInitializationSettings();

    const initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOsInitialize);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (Platform.isAndroid) {
      var androidInfo = await _getAndroidInfo();

      if (androidInfo.version.sdkInt >= 26 /* Android 8.0 or newer */) {
        await _createChannelGroup(_notificationGroups);
        await _createChannelNotification(_notificationChannels);
      }
      if (androidInfo.version.sdkInt >= 33 /* Android 13.0 */) {
        await _requestNotificationPermission();
      }
    }
    log("Notification Service Successful Initialize");
  }

  /// Show Notification
  /// @Param channelId
  static Future<void> showNotification(
      {required dynamic channelId,
      String? title,
      String? body,
      String? payload}) async {
    Map<String, dynamic> notification = _notificationChannels
        .firstWhere((channel) => channel["id"] == channelId);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(notification["id"], notification["name"],
            channelShowBadge: true,
            enableVibration: true,
            playSound: true,
            groupKey: notification["groupId"],
            importance: Importance.max,
            // fullScreenIntent: true,
            priority: Priority.max,
            styleInformation: const BigTextStyleInformation(''));

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(presentAlert: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
        _notificationId, title, body, notificationDetails,
        payload: payload);
    _notificationId++;
  }

  static Future<void> _createChannelNotification(List channels) async {
    for (var channel in channels) {
      AndroidNotificationChannel notificationChannel =
          AndroidNotificationChannel(channel["id"], channel["name"],
              description: channel["description"],
              enableVibration: true,
              groupId: channel["groupId"],
              playSound: true,
              sound: RawResourceAndroidNotificationSound(channel["sound"]),
              showBadge: true,
              enableLights: true,
              importance: Importance.max);

      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(notificationChannel);
    }
  }

  static Future<void> _createChannelGroup(
      List<Map<String, dynamic>> channelGroups) async {
    for (var group in channelGroups) {
      AndroidNotificationChannelGroup notificationChannelGroup =
          AndroidNotificationChannelGroup(group["id"], group["name"]);

      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannelGroup(notificationChannelGroup);
      log('Create/Update Notification Group Channel');
    }
  }

  static Future<AndroidDeviceInfo> _getAndroidInfo() async {
    AndroidDeviceInfo? deviceInfo;
    deviceInfo ??= await DeviceInfoPlugin().androidInfo;
    return deviceInfo;
  }

  static Future<void> _requestNotificationPermission() async {
    var requestExactAlarmsPermission = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    var requestNotificationsPermission = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (requestExactAlarmsPermission =
        true && requestExactAlarmsPermission != null) {
      log("Exact Alarm Permission Access Granted");
    }
    if (requestNotificationsPermission =
        true && requestNotificationsPermission != null) {
      log("Notification Permission Access Granted");
    }
  }
}
