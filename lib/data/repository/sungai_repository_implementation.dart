import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/datasources/firebase_data_source.dart';
import 'package:ta_ews_application/data/model/data_sungai_model.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';

class SungaiRepositoryImplementation implements SungaiRepository {
  const SungaiRepositoryImplementation(this._dataSource);

  final FirebaseDataSource _dataSource;

  @override
  Future<Either<Exception, DataSungaiModel>> getTitle() async {
    try {
      final result = await _dataSource.getDataSungai();
      return Right(result);
    } catch (e, stack) {
      if (kDebugMode) {
        print('Error repoimpl: $e $stack');
      }
      return Left(Exception(['Gagal']));
    }
  }

  @override
  StreamSubscription<DatabaseEvent> getDataSensor() {
    return _dataSource.getDataSensor();
  }

  @override
  Stream<DatabaseEvent> getDataSensorNew() {
    return _dataSource.getDataSensorNew();
  }
}
