import 'package:dartz/dartz.dart';
import 'package:ta_ews_application/domain/entity/sungai.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';

class GetDataSungaiUseCase {
  const GetDataSungaiUseCase(this._repository);

  final SungaiRepository _repository;

  Future<Either<Exception, Sungai>> exec({required String idSungai}) async =>
      _repository.getDataSungai(idSungai: idSungai);
}
