import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/domain/entity/data_sungai.dart';

abstract class SungaiRepository {
  Future<Either<Exception, DataSungai>> getTitle();
  StreamSubscription<DatabaseEvent> getDataSensor();
  Stream<DatabaseEvent> getDataSensorNew();
}
