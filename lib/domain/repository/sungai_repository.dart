import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
// import 'package:ta_ews_application/core.dart';
// import 'package:ta_ews_application/data/model/sungai_model.dart';
import 'package:ta_ews_application/domain/entity/data_sensor_new.dart';
import 'package:ta_ews_application/domain/entity/sungai.dart';

abstract class SungaiRepository {
  // Future<Either<Exception, Sungai>> getTitle();
  // StreamSubscription<DatabaseEvent> getDataSensor();
  // Stream<DatabaseEvent> getDataSensorNew();

  Future<Either<Exception, List<Sungai>>> getListSungai();
  Future<Either<Exception, Sungai>> getDataSungai({required String idSungai});
  Stream<DocumentSnapshot<DataSensorNew>> getDataRealtimeSensor(
      {required String idSungai});
  Future<Either<Exception, List<DataSensorNew>>> getHistory(
      {required String idSungai, required String tanggal});
}
