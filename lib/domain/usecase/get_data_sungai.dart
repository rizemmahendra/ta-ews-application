import 'package:dartz/dartz.dart';
import 'package:ta_ews_application/domain/entity/data_sungai.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';

class GetDataSungai {
  const GetDataSungai(this._repository);

  final SungaiRepository _repository;

  Future<Either<Exception, DataSungai>> getDataSungai() async =>
      _repository.getTitle();
}
