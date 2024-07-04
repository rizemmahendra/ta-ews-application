// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ta_ews_application/app.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/services/notification_service.dart';
import 'package:ta_ews_application/dependecy_injection.dart';
import 'package:ta_ews_application/firebase_options.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");

  if (message.data.isNotEmpty) {
    String? title = message.data["title"];
    String? body = message.data["body"];
    String? channelId = message.data["channelId"];

    NotificationService.showNotification(
        channelId: channelId, title: title, body: body);
  }
}

void _firebaseMessagingForegroundHandler(RemoteMessage message) async {
  await NotificationService.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  log('Got a message whilst in the foreground!');
  log('Message data: ${message.data}');
  log('channel id : ${message.notification?.android?.channelId}');

  if (message.notification?.android != null) {
    String? title = '${message.notification?.title} Local Notification';
    String? body = message.notification?.body;
    String? channelId = message.notification?.android?.channelId;

    NotificationService.showNotification(
        channelId: channelId, title: title, body: body);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependecyInjection.initialize();
  await NotificationService.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseMessaging.instance
      .subscribeToTopic('ta_ews_rizemmahendra')
      .then((event) => log('Subcribe to channel ta_ews_rizemmahendra Berhasil'))
      .onError((error, stackTrace) => log(error.toString()));

  FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependecyInjection.sl<SungaiBloc>()
        ..add(const GetDataSungai(idSungai: 'axBPVZsdXUAjFyWOlXnt'))
        ..add(GetDataHistorySensor('axBPVZsdXUAjFyWOlXnt',
            DateTime.now().toString().substring(0, 10))),
      child: MaterialApp(
        theme: ThemeData(
            textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                backgroundColor: Constant.orange,
                elevation: 0,
                shape: Border.all(width: 0, color: Constant.grey)),
            navigationBarTheme: const NavigationBarThemeData(
                backgroundColor: Constant.orange,
                indicatorColor: Colors.white,
                labelTextStyle:
                    MaterialStatePropertyAll(TextStyle(color: Colors.white)))),
        home: const App(),
      ),
    );
  }
}
