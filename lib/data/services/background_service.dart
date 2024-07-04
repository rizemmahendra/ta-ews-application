import 'dart:developer';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/services/notification_service.dart';
import 'package:ta_ews_application/dependecy_injection.dart';
import 'package:ta_ews_application/domain/usecase/get_data_realtime_sensor.dart';
import 'package:ta_ews_application/firebase_options.dart';

class BackgroundService {
  static final FlutterBackgroundService _service = FlutterBackgroundService();

  static Future<void> initialize() async {
    if (await _service.isRunning()) {
      log('Service still Running');
      return;
    }
    IosConfiguration iosConfiguration = IosConfiguration();
    AndroidConfiguration androidConfiguration = AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
      autoStart: true,
    );

    await NotificationService.initialize();

    await _service.configure(
        iosConfiguration: iosConfiguration,
        androidConfiguration: androidConfiguration);
    log('Background Service is Running');
    return;
  }

  @pragma('vm:entry-point')
  static Future<void> onStart(ServiceInstance serviceInstance) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    DependecyInjection.initializeOnBackground();
    log('================= onStart Service ===================');

    serviceInstance.on('stopService').listen((event) {
      serviceInstance.stopSelf();
    });

    serviceInstance.on('changeIdSungai').listen((event) {
      event?[''];
    });

    try {
      String statusNode1 = '';
      String statusNode2 = '';
      String prevStatusNode1 = '';
      String prevStatusNode2 = '';
      log('Listen Firestore');
      DependecyInjection.sl<GetDataRealtimeSensorUseCase>()
          .exec(idSungai: 'axBPVZsdXUAjFyWOlXnt')
          .listen((event) async {
        var data = event.data()!;
        log(data.toString());
        statusNode1 = data.node1['levelDanger'];
        statusNode2 = data.node2['levelDanger'];
        if (prevStatusNode1 != statusNode1 && statusNode1 == "bahaya" ||
            statusNode1 == "sangat bahaya") {
          log('Show Notif node 1');
          await NotificationService.showNotification(
              channelId: 1,
              title: 'Status Sungai di Node 1 : $statusNode1',
              body:
                  'Ketinggian air\t: ${data.node1['waterLevel']} CM\nKekeruhan Air\t: ${data.node1['waterTurbidity']} NTU\nIntensitas Hujan\t: ${data.node1['rainIntensity']} mm/hour');
        }
        if (prevStatusNode2 != statusNode2 && statusNode2 == "bahaya" ||
            statusNode2 == "sangat bahaya") {
          log('Show notif node 2');
          await NotificationService.showNotification(
              channelId: 1,
              title: 'Status Sungai di Node 2 : $statusNode2',
              body:
                  'Ketinggian air\t: ${data.node2['waterLevel']} CM\nKekeruhan Air\t: ${data.node2['waterTurbidity']} NTU\nIntensitas Hujan\t: ${data.node2['rainIntensity']} mm/hour');
        }
        log('Status node 1 : $prevStatusNode1 => $statusNode1');
        log('Status node 2 : $prevStatusNode2 => $statusNode2');
        prevStatusNode1 = statusNode1;
        prevStatusNode2 = statusNode2;
      });
    } catch (e) {
      NotificationService.showNotification(
          channelId: 1, title: 'ERROR', body: e.toString());
    }
  }
}
