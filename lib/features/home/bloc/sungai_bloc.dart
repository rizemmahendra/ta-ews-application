import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_ews_application/domain/entity/data_sensor_new.dart';
import 'package:ta_ews_application/domain/entity/sungai.dart';
import 'package:ta_ews_application/domain/usecase/get_data_history.dart';
import 'package:ta_ews_application/domain/usecase/get_data_realtime_sensor.dart';
import 'package:ta_ews_application/domain/usecase/get_data_sungai.dart';
import 'package:ta_ews_application/domain/usecase/get_list_sungai.dart';

part 'sungai_event.dart';
part 'sungai_state.dart';

class SungaiBloc extends Bloc<SungaiBlocEvent, SungaiState> {
  SungaiBloc(
      {required GetListSungaiUseCase listSungaiUseCase,
      required GetDataSungaiUseCase dataSungaiUseCase,
      required GetDataRealtimeSensorUseCase dataRealtimeSensorUseCase,
      required GetDataHistoryUseCase dataHistoryUseCase})
      : _listSungaiUseCase = listSungaiUseCase,
        _dataSungaiUseCase = dataSungaiUseCase,
        _dataRealtimeSensorUseCase = dataRealtimeSensorUseCase,
        _dataHistoryUseCase = dataHistoryUseCase,
        super(const SungaiInitial()) {
    on<GetListSungai>(_getListSungaiHandler);
    on<GetDataSungai>(_getDataSungaiHandler);
    on<GetDataRealtimeSensor>(_getDataRealtimeSensorHandler);
    on<UpdateDataRealtimeSensor>(_updateDataRealtimeSensorHandler);
    on<GetDataHistorySensor>(_getDataHistorySensor);
    if (kDebugMode) {
      print("Sungai New Bloc Created");
    }
  }

  final GetListSungaiUseCase _listSungaiUseCase;
  final GetDataSungaiUseCase _dataSungaiUseCase;
  final GetDataRealtimeSensorUseCase _dataRealtimeSensorUseCase;
  final GetDataHistoryUseCase _dataHistoryUseCase;
  StreamSubscription<DocumentSnapshot<DataSensorNew>>? _streamSubscription;

  FutureOr<void> _getListSungaiHandler(
      GetListSungai event, Emitter<SungaiState> emit) async {
    var result = await _listSungaiUseCase.exec();
    result.fold((error) => error.toString(), (data) => data);
  }

  FutureOr<void> _getDataSungaiHandler(
      GetDataSungai event, Emitter<SungaiState> emit) async {
    emit(const GettingDataSungai());
    final result = await _dataSungaiUseCase.exec(idSungai: event._idSungai);
    result.fold((error) => error, (data) {
      emit(LoadedDataSungai(dataSungai: data));
      add(const GetDataRealtimeSensor('axBPVZsdXUAjFyWOlXnt'));
    });
  }

  FutureOr<void> _getDataRealtimeSensorHandler(
      GetDataRealtimeSensor event, Emitter<SungaiState> emit) async {
    if (_streamSubscription != null) {
      await _streamSubscription?.cancel();
    }
    _streamSubscription = _dataRealtimeSensorUseCase
        .exec(idSungai: event.id)
        .listen((event) async {
      var dataSensor = event.data()!;
      add(UpdateDataRealtimeSensor(data: dataSensor));
    });
  }

  FutureOr<void> _updateDataRealtimeSensorHandler(
      UpdateDataRealtimeSensor event, Emitter<SungaiState> emit) {
    emit(const GettingDataRealtimeSensor());
    emit(LoadedDataRealtimeSensor(dataSensor: event.data));
  }

  FutureOr<void> _getDataHistorySensor(
      GetDataHistorySensor event, Emitter<SungaiState> emit) async {
    final result =
        await _dataHistoryUseCase.exec(idSungai: event.id, tanggal: event.date);
    result.fold((l) => null, (r) => null);
  }

  @override
  void onChange(Change<SungaiState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print(change);
    }
  }

  @override
  Future<void> close() async {
    if (_streamSubscription != null) {
      await _streamSubscription?.cancel();
    }
    return super.close();
  }
}
