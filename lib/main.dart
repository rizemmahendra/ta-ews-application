// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ta_ews_application/app.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/dependecy_injection.dart';
import 'package:ta_ews_application/firebase_options.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';
import 'package:ta_ews_application/data/services/notification_service.dart';
import 'data/services/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependecyInjection.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await BackgroundService.initialize();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependecyInjection.sl<SungaiBloc>()
        // ..idSungai = ''
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
