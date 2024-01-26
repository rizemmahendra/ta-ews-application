import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/datasources/firestore.dart';
import 'package:ta_ews_application/data/repository/sungai_repository_implementation.dart';
import 'package:ta_ews_application/data/services/notification_service.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';
import 'package:ta_ews_application/domain/usecase/get_data_history.dart';
import 'package:ta_ews_application/domain/usecase/get_data_realtime_sensor.dart';
import 'package:ta_ews_application/domain/usecase/get_data_sungai.dart';
import 'package:ta_ews_application/domain/usecase/get_list_sungai.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> initInjection() async {
  if (kDebugMode) {
    print('============= initialize DI =============');
  }
  sl
      // Bloc
      .registerFactory(() => SungaiBloc(
          listSungaiUseCase: sl(),
          dataSungaiUseCase: sl(),
          dataRealtimeSensorUseCase: sl(),
          dataHistoryUseCase: sl()));

  // Usecase
  sl
    ..registerLazySingleton(() => GetListSungaiUseCase(sl()))
    ..registerLazySingleton(() => GetDataSungaiUseCase(sl()))
    ..registerLazySingleton<GetDataRealtimeSensorUseCase>(
        () => GetDataRealtimeSensorUseCase(sl()))
    ..registerLazySingleton(() => GetDataHistoryUseCase(sl()))

    // Repository
    ..registerLazySingleton<SungaiRepository>(
        () => SungaiRepositoryImplementation(sl()))

    // DataSource
    ..registerLazySingleton<RemoteDataSource>(
        () => FirestoreDataSource(instance: sl()))

    // Service
    ..registerLazySingleton(() => NotificationService())

    // Firebase Instance
    ..registerLazySingleton(() => FirebaseFirestore.instance);
}

class DependecyInjection {
  static final GetIt _sl = GetIt.instance;

  static GetIt get sl => _sl;

  static Future<void> initialize() async {
    _sl
        // Bloc
        .registerFactory(() => SungaiBloc(
            listSungaiUseCase: sl(),
            dataSungaiUseCase: sl(),
            dataRealtimeSensorUseCase: sl(),
            dataHistoryUseCase: sl()));

    // Usecase
    _sl
      ..registerLazySingleton(() => GetListSungaiUseCase(sl()))
      ..registerLazySingleton(() => GetDataSungaiUseCase(sl()))
      ..registerLazySingleton<GetDataRealtimeSensorUseCase>(
          () => GetDataRealtimeSensorUseCase(sl()))
      ..registerLazySingleton(() => GetDataHistoryUseCase(sl()))

      // Repository
      ..registerLazySingleton<SungaiRepository>(
          () => SungaiRepositoryImplementation(sl()))

      // DataSource
      ..registerLazySingleton<RemoteDataSource>(
          () => FirestoreDataSource(instance: sl()))

      // Service
      ..registerLazySingleton(() => NotificationService())

      // Firebase Instance
      ..registerLazySingleton(() => FirebaseFirestore.instance);
  }

  @pragma('vm:entry-point')
  static Future<void> initializeOnBackground() async {
    sl
      ..registerFactory<GetDataRealtimeSensorUseCase>(
          () => GetDataRealtimeSensorUseCase(sl()))
      ..registerLazySingleton(() => GetDataHistoryUseCase(sl()))

      // Repository
      ..registerLazySingleton<SungaiRepository>(
          () => SungaiRepositoryImplementation(sl()))

      // DataSource
      ..registerLazySingleton<RemoteDataSource>(
          () => FirestoreDataSource(instance: sl()))

      // Service
      ..registerLazySingleton(() => NotificationService())

      // Firebase Instance
      ..registerLazySingleton(() => FirebaseFirestore.instance);
  }
}
