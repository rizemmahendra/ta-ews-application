import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/domain/entity/data_history.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';

class GetListHistoryUseCase {
  GetListHistoryUseCase(this._repository);

  final SungaiRepository _repository;

  Stream<QuerySnapshot<DataHistory>> exec({required String idSungai}) {
    return _repository.getListHistory(idSungai: idSungai);
  }
}
