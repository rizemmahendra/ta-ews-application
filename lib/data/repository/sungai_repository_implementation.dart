// ignore_for_file: unused_import

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/datasources/firebase_data_source.dart';
import 'package:ta_ews_application/data/datasources/firestore.dart';
import 'package:ta_ews_application/data/model/data_history_sensor_model.dart';
import 'package:ta_ews_application/data/model/data_sungai_model.dart';
import 'package:ta_ews_application/domain/entity/data_sensor_new.dart';
import 'package:ta_ews_application/domain/entity/sungai.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';

class SungaiRepositoryImplementation implements SungaiRepository {
  const SungaiRepositoryImplementation(this._dataSource);

  final RemoteDataSource _dataSource;

  @override
  Future<Either<Exception, List<Sungai>>> getListSungai() async {
    try {
      final result = await _dataSource.getListSungai();
      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Sungai>> getDataSungai(
      {required String idSungai}) async {
    try {
      final result = await _dataSource.getDataSungai(idSungai: idSungai);
      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Stream<DocumentSnapshot<DataSensorNew>> getDataRealtimeSensor(
      {required String idSungai}) {
    return _dataSource.getDataRealtimeSensor(idSungai: idSungai);
  }

  @override
  Future<Either<Exception, DataHistorySensorModel>> getHistory(
      {required String idSungai, required String tanggal}) async {
    try {
      final result =
          await _dataSource.getHistory(idSungai: idSungai, tanggal: tanggal);
      if (result.isEmpty) return Right(DataHistorySensorModel.empty());
      return Right(DataHistorySensorModel.fromListDataSensor(result));
    } catch (e) {
      return Left(Exception(e));
    }
  }

  // @override
  // Future<Either<Exception, DataSungaiModel>> getTitle() async {
  //   try {
  //     final result = await _dataSource.getDataSungai();
  //     return Right(result);
  //   } catch (e, stack) {
  //     if (kDebugMode) {
  //       print('Error repoimpl: $e $stack');
  //     }
  //     return Left(Exception(['Gagal']));
  //   }
  // }

  // @override
  // StreamSubscription<DatabaseEvent> getDataSensor() {
  //   return _dataSource.getDataSensor();
  // }

  // @override
  // Stream<DatabaseEvent> getDataSensorNew() {
  //   return _dataSource.getDataSensorNew();
  // }
}
