import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ta_ews_application/data/model/data_history_sensor_model.dart';
import 'package:ta_ews_application/domain/entity/data_sensor.dart';
import 'package:ta_ews_application/domain/entity/sungai.dart';

abstract class SungaiRepository {
  Future<Either<Exception, List<Sungai>>> getListSungai();
  Future<Either<Exception, Sungai>> getDataSungai({required String idSungai});
  Stream<DocumentSnapshot<DataSensor>> getDataRealtimeSensor(
      {required String idSungai});
  Future<Either<Exception, DataHistorySensorModel>> getHistory(
      {required String idSungai, required String tanggal});
}
