// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'dart:async';

import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/data/model/data_sungai_model.dart';

class FirebaseDataSource {
  final FirebaseDatabase _instance;
  late DatabaseReference _ref;

  FirebaseDataSource(this._instance) {
    _ref = _instance.ref();
  }

  Future<DataSungaiModel> getDataSungai() async {
    final namaSungai = await _ref.child('river_name').get();
    final lokasiSungai = await _ref.child('river_location').get();
    final koordinatSungai = await _ref
        .child('river_coordinat')
        .get()
        .onError((error, stackTrace) => throw UnimplementedError());

    return DataSungaiModel(
        namaSungai: namaSungai.value as String,
        lokasiSungai: lokasiSungai.value as String,
        koordinatSungai: koordinatSungai.value as String);

    // throw UnimplementedError();
  }

  StreamSubscription<DatabaseEvent> getDataSensor() {
    // DatabaseReference ref = _instance.ref('sensor');
    return _ref.child('sensor_measurement').onValue.listen((event) {});
  }

  Stream<DatabaseEvent> getDataSensorNew() {
    // DatabaseReference ref = _instance.ref('sensor');
    return _ref.child('sensor_measurement').onValue;
  }
}
