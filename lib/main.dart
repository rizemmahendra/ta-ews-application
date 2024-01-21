import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/app.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/dependecy_injection.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';
import 'package:ta_ews_application/firebase_options.dart';

void main() async {
  initInjection();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});

  final sungaiBloc = sl<SungaiBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sungaiBloc
        ..add(const GetDataSungai(idSungai: 'axBPVZsdXUAjFyWOlXnt'))
        ..add(const GetDataHistorySensor('axBPVZsdXUAjFyWOlXnt', '2024-01-17')),
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Constant.orange,
                elevation: 0,
                shape: Border.all(width: 0, color: Constant.grey)),
            navigationBarTheme: const NavigationBarThemeData(
              backgroundColor: Constant.orange,
            )),
        home: const App(),
      ),
    );
  }
}
