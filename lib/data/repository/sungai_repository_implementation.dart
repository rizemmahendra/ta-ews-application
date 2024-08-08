import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/datasources/firestore.dart';
import 'package:ta_ews_application/domain/entity/data_history.dart';
import 'package:ta_ews_application/domain/entity/data_sensor.dart';
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
  Stream<DocumentSnapshot<DataSensor>> getDataRealtimeSensor(
      {required String idSungai}) {
    return _dataSource.getDataRealtimeSensor(idSungai: idSungai);
  }

  @override
  Future<Either<Exception, List<DataHistory>>> getHistory(
      {required String idSungai, required String tanggal}) async {
    try {
      final result =
          await _dataSource.getHistory(idSungai: idSungai, tanggal: tanggal);
      return Right(result);
    } catch (e, stacktrace) {
      return Left(Exception([e, stacktrace]));
    }
  }
}
