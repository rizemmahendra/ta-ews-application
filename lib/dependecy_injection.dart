import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/datasources/firestore.dart';
import 'package:ta_ews_application/data/repository/sungai_repository_implementation.dart';
import 'package:ta_ews_application/data/services/notification.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';
import 'package:ta_ews_application/domain/usecase/get_data_history.dart';
import 'package:ta_ews_application/domain/usecase/get_data_realtime_sensor.dart';
import 'package:ta_ews_application/domain/usecase/get_data_sungai.dart';
import 'package:ta_ews_application/domain/usecase/get_list_sungai.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> initInjection() async {
  sl
    // Bloc
    ..registerFactory(() => SungaiBloc(
        listSungaiUseCase: sl(),
        dataSungaiUseCase: sl(),
        dataRealtimeSensorUseCase: sl(),
        dataHistoryUseCase: sl()))

    // Usecase
    ..registerLazySingleton(() => GetListSungaiUseCase(sl()))
    ..registerLazySingleton(() => GetDataSungaiUseCase(sl()))
    ..registerLazySingleton(() => GetDataRealtimeSensorUseCase(sl()))
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
