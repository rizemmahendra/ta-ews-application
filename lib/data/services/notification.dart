import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const String _notificationChannelId = 'notificationService';
  static const String _notificationChannelName = 'Notification Service';
  static const int _notificationId = 1205;

  int get id => _notificationId;

  Future<void> initialize() async {
    const androidInitialize =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const iOsInitialize = DarwinInitializationSettings();
    const initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOsInitialize);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel androidChannel =
        AndroidNotificationChannel(
            _notificationChannelId, _notificationChannelName,
            description: 'Channel for notification App',
            enableVibration: true,
            playSound: true,
            importance: Importance.high);

    var androidInfo = await DeviceInfoPlugin().androidInfo;
    if (Platform.isAndroid) {
      if (androidInfo.version.sdkInt >= 26 /* Android 8.0 or newer */) {
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(androidChannel);
      }
      if (androidInfo.version.sdkInt >= 33 /* Android 13.0 */) {
        var requestExactAlarmsPermission =
            await _flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestExactAlarmsPermission();
        if (requestExactAlarmsPermission =
            true && requestExactAlarmsPermission != null) {
          if (kDebugMode) {
            print("Exact Alarm Permission Access Granted");
          }
        }
        var requestNotificationsPermission =
            await _flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestNotificationsPermission();
        if (requestNotificationsPermission =
            true && requestNotificationsPermission != null) {
          if (kDebugMode) {
            print("Notification Permission Access Granted");
          }
        }
      }
    }
    if (kDebugMode) {
      print("Notification Service Successful Initialize");
    }
  }

  Future<void> showNotification(
      {String? title, String? body, String? payload}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            _notificationChannelId, _notificationChannelName,
            enableVibration: true,
            playSound: true,
            importance: Importance.high,
            priority: Priority.high);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(presentAlert: true, presentSound: true);

    const notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
        _notificationId, title, body, notificationDetails,
        payload: payload);
  }
}
