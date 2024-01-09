import 'package:get_it/get_it.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/datasources/firebase_data_source.dart';
import 'package:ta_ews_application/data/repository/sungai_repository_implementation.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';
import 'package:ta_ews_application/domain/usecase/get_data_sensor.dart';
import 'package:ta_ews_application/domain/usecase/get_data_sungai.dart';
import 'package:ta_ews_application/features/home/bloc/data_sungai_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> initInjection() async {
  sl
    // DataSungaiBloc
    ..registerFactory(
        () => DataSungaiBloc(getDataSungai: sl(), getDataSensor: sl()))

    // Usecase
    ..registerLazySingleton(() => GetDataSungai(sl()))
    ..registerLazySingleton(() => GetDataSensor(sl()))

    // Repository
    ..registerLazySingleton<SungaiRepository>(
        () => SungaiRepositoryImplementation(sl()))

    //DataSource
    ..registerLazySingleton(() => FirebaseDataSource(sl()))

    // Firebase Instance
    ..registerLazySingleton(() => FirebaseDatabase.instance);
}
