// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ta_ews_application/app.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/dependecy_injection.dart';
import 'package:ta_ews_application/firebase_options.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';

// import 'data/services/background_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  log("Handling a background message: ${message.messageId}");
  log('title : ${message.notification?.title}');
  log('title : ${message.notification?.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DependecyInjection.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseMessaging.instance
      .subscribeToTopic('ta_ews')
      .then((event) => log('Berhasil'))
      .onError((error, stackTrace) => log(error.toString()));
  log("FCMToken $fcmToken");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Got a message whilst in the foreground!');
    log('Message data: ${message.data}');
    log('channel id : ${message.notification?.android?.channelId}');

    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification}');
      log('title : ${message.notification?.title}');
      log('title : ${message.notification?.body}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance
      .getNotificationSettings()
      .then((value) => log(value.toString()));

  OneSignal.initialize("d1a5fcad-c202-4770-b95b-13deb1eaadc2");
  OneSignal.Notifications.requestPermission(true);

  // await BackgroundService.initialize();
  runApp(MyWidget(
    data: fcmToken!,
  ));
}

// ignore: must_be_immutable
class MyWidget extends StatelessWidget {
  MyWidget({
    super.key,
    this.data = "",
  });

  String data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(data),
        ),
      ),
    );
  }
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
