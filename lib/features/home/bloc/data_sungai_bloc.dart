import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_ews_application/data/model/data_sensor_model.dart';
import 'package:ta_ews_application/domain/entity/data_sensor.dart';
import 'package:ta_ews_application/domain/entity/data_sungai.dart';
import 'package:ta_ews_application/domain/usecase/get_data_sensor.dart';
import 'package:ta_ews_application/domain/usecase/get_data_sungai.dart';

part 'data_sungai_event.dart';
part 'data_sungai_state.dart';

class DataSungaiBloc extends Bloc<DataSungaiEvent, DataSungaiState> {
  DataSungaiBloc(
      {required GetDataSungai getDataSungai,
      required GetDataSensor getDataSensor})
      : _getDataSungai = getDataSungai,
        _getDataSensor = getDataSensor,
        super(const DataSungaiInitial()) {
    on<GetDataSungaiEvent>(_getDataSungaiHandler);
    on<SubscribeDataSensor>(_subscribeDataSensorHandler);
    on<UpdateDataSensor>(_updateDataSensorHandler);
  }

  final GetDataSungai _getDataSungai;
  final GetDataSensor _getDataSensor;

  Future<void> _getDataSungaiHandler(
      GetDataSungaiEvent event, Emitter<DataSungaiState> emit) async {
    emit(const GettingDataSungai());
    Future.delayed(const Duration(seconds: 10));
    final result = await _getDataSungai.getDataSungai();
    result.fold((failure) => emit(const ErrorGetDataSungai()), (data) {
      emit(LoadedDataSungai(data));
      Future.delayed(const Duration(seconds: 2));
    });
  }

  Future<void> _subscribeDataSensorHandler(
      SubscribeDataSensor event, Emitter<DataSungaiState> emit) async {
    _getDataSensor.getData().onData((data) {
      Map<String, dynamic> sensor =
          Map<String, dynamic>.from(data.snapshot.value as Map);
      DataSensorModel dataSensor = DataSensorModel.fromMap(sensor);
      add(UpdateDataSensor(dataSensor));
    });
  }

  Future<void> _updateDataSensorHandler(
      UpdateDataSensor event, Emitter<DataSungaiState> emit) async {
    emit(const LoadDataSensor());
    emit(LoadedDataSensor(event.dataSensor));
  }

  @override
  void onChange(Change<DataSungaiState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print(change);
    }
  }
}
