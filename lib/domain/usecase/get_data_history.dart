import 'package:dartz/dartz.dart';
import 'package:ta_ews_application/data/model/data_history_sensor_model.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';

class GetDataHistoryUseCase {
  GetDataHistoryUseCase(this._repository);

  final SungaiRepository _repository;

  Future<Either<Exception, DataHistorySensorModel>> exec(
      {required String idSungai, required String tanggal}) {
    return _repository.getHistory(idSungai: idSungai, tanggal: tanggal);
  }
}
