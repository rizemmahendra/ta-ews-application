import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta_ews_application/domain/entity/data_sensor.dart';
import 'package:ta_ews_application/domain/repository/sungai_repository.dart';

class GetDataRealtimeSensorUseCase {
  const GetDataRealtimeSensorUseCase(this._repository);

  final SungaiRepository _repository;

  Stream<DocumentSnapshot<DataSensor>> exec({required String idSungai}) {
    return _repository.getDataRealtimeSensor(idSungai: idSungai);
  }
}
