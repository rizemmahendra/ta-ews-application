import 'package:dartz/dartz.dart';
import 'package:ta_ews_application/domain/entity/sungai.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';

class GetListSungaiUseCase {
  const GetListSungaiUseCase(this._repository);

  final SungaiRepository _repository;

  Future<Either<Exception, List<Sungai>>> exec() {
    return _repository.getListSungai();
  }
}
