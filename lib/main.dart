import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/app.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/dependecy_injection.dart';
import 'package:ta_ews_application/features/home/bloc/data_sungai_bloc.dart';
import 'package:ta_ews_application/firebase_options.dart';

void main() async {
  initInjection();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DataSungaiBloc>()
        ..add(const GetDataSungaiEvent())
        ..add(const SubscribeDataSensor()),
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
        // home: const MyApp(),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     DataSungaiBloc sungaiBloc = context.read<DataSungaiBloc>();
//     sungaiBloc.add(const GetDataSungaiEvent());

//     return Scaffold(
//       body: BlocBuilder<DataSungaiBloc, DataSungaiState>(
//         builder: (context, state) {
//           if (state is LoadedDataSungai) {
//             return Center(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(state.dataSungai.namaSungai),
//                     Text(state.dataSungai.lokasiSungai),
//                     Text(state.dataSungai.koordinatSungai)
//                   ]),
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.red,
//               value: 10,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
